import 'dart:async';

import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:ecommerce/repositories/address_repository.dart';
import 'package:flutter/foundation.dart';
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

  /// Refetches the address list without showing a loading state, so a
  /// mutation's own refetch doesn't flash the list to a spinner.
  Future<void> _refreshState() async {
    state = await AsyncValue.guard(_fetchState);
  }

  /// Runs [operation] against the signed-in user's ID, refetching the
  /// address list afterwards. Write failures and refetch failures are kept
  /// separate: if [operation] throws, the refetch is skipped so a refetch
  /// error can never be reported as if the write itself had failed.
  Future<bool> _performMutation(
    Future<void> Function(String userId) operation, {
    String? successMessage,
  }) async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) {
      TSnacksLoader.errorSnackBar(
        title: 'Oh Snap!',
        message: 'You need to be signed in to do this.',
      );
      return false;
    }

    try {
      await operation(userId);
    } catch (e) {
      debugPrint('AddressController mutation failed: $e');
      TSnacksLoader.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong. Please try again.',
      );
      return false;
    }

    await _refreshState();
    if (successMessage != null) {
      TSnacksLoader.successSnackBar(title: 'Success', message: successMessage);
    }
    return true;
  }

  Future<bool> addAddress(AddressModel address) => _performMutation(
    (userId) => _addressRepository.addAddress(userId, address),
    successMessage: 'Address added.',
  );

  Future<bool> updateAddress(AddressModel address) => _performMutation(
    (userId) => _addressRepository.updateAddress(userId, address),
    successMessage: 'Address updated.',
  );

  Future<bool> deleteAddress(String addressId) => _performMutation(
    (userId) => _addressRepository.deleteAddress(userId, addressId),
    successMessage: 'Address removed.',
  );

  /// Marks [addressId] as the selected address, unselecting any other.
  Future<bool> selectAddress(String addressId) => _performMutation(
    (userId) => _addressRepository.selectAddress(userId, addressId),
  );
}
