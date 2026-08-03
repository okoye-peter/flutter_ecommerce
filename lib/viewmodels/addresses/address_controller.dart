import 'dart:async';

import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:ecommerce/repositories/address_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_controller.g.dart';

@Riverpod(keepAlive: true)
class AddressController extends _$AddressController {
  late final AddressRepository _addressRepository;

  @override
  FutureOr<List<AddressModel>> build() {
    _addressRepository = AddressRepository();
    return _fetchState();
  }

  AddressModel getSelectedAddress() {
    final addresses = state.value ?? [];
    return addresses.firstWhere(
      (address) => address.isSelectedAddress == true,
      orElse: () =>
          addresses.isNotEmpty ? addresses.first : AddressModel.empty(),
    );
  }

  Future<void> fetchAddresses() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchState);
  }

  Future<List<AddressModel>> _fetchState() async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return [];

    return _addressRepository.fetchAddresses(userId);
  }

  Future<bool> addAddress(AddressModel address) async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return false;

    try {
      await _addressRepository.addAddress(userId, address);
      state = AsyncValue.data(await _fetchState());
      TSnacksLoader.successSnackBar(
        title: 'Success',
        message: 'Address added.',
      );
      return true;
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return false;
    }
  }

  Future<bool> updateAddress(AddressModel address) async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return false;

    try {
      await _addressRepository.updateAddress(userId, address);
      state = AsyncValue.data(await _fetchState());
      TSnacksLoader.successSnackBar(
        title: 'Success',
        message: 'Address updated.',
      );
      return true;
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return false;
    }
  }

  Future<bool> deleteAddress(String addressId) async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return false;

    try {
      await _addressRepository.deleteAddress(userId, addressId);
      state = AsyncValue.data(await _fetchState());
      TSnacksLoader.successSnackBar(
        title: 'Success',
        message: 'Address removed.',
      );
      return true;
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return false;
    }
  }

  /// Marks [addressId] as the selected address, unselecting any other.
  Future<bool> selectAddress(String addressId) async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return false;

    try {
      await _addressRepository.selectAddress(userId, addressId);
      state = AsyncValue.data(await _fetchState());
      return true;
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return false;
    }
  }
}
