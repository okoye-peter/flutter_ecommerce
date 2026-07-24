import 'dart:async';

import 'package:ecommerce/models/banner_model.dart';
import 'package:ecommerce/repositories/banner_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_controller.g.dart';

final class BannerState {
  BannerState({required this.count, required this.banners});

  final int count;
  final List<BannerModel> banners;

  BannerState copyWith({int? updatedCount, List<BannerModel>? updatedBanners}) {
    return BannerState(
      count: updatedCount ?? count,
      banners: updatedBanners ?? banners,
    );
  }
}

@riverpod
class BannerController extends _$BannerController {
  late final BannerRepository _bannerRepository;

  @override
  FutureOr<BannerState> build() {
    _bannerRepository = BannerRepository();
    return _fetchState();
  }

  Future<void> fetchBanners() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchState);
  }

  Future<BannerState> _fetchState() async {
    final banners = await _bannerRepository.fetchBanners();
    return BannerState(count: 0, banners: banners);
  }

  void updatePageIndicator(int index) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(updatedCount: index));
  }
}
