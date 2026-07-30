import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:ecommerce/repositories/brand_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'brand_controller.g.dart';

@Riverpod(keepAlive: true)
class BrandController extends _$BrandController {
  late final BrandRepository _repo;

  @override
  Future<List<BrandModel>> build() {
    _repo = BrandRepository();
    return getAllBrands();
  }

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final brands = await _repo.getAllBrands();
      return brands;
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  List<BrandModel> getFeaturedBrands() {
    return (state.value ?? []).where((b) => b.isFeatured == true).toList();
  }
}
