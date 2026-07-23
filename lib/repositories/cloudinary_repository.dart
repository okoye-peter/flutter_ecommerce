import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/config/cloudinary_config.dart';

class CloudinaryRepository {
  CloudinaryRepository({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// Uploads [image] to Cloudinary using an unsigned upload preset and
  /// returns the resulting `secure_url`.
  Future<String> uploadImage(File image) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
        'upload_preset': TCloudinaryConfig.uploadPreset,
      });

      final response = await _dio.post(
        'https://api.cloudinary.com/v1_1/${TCloudinaryConfig.cloudName}/image/upload',
        data: formData,
      );

      return response.data['secure_url'] as String;
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map ? (data['error']?['message'] as String?) : null;
      throw message ?? 'Could not upload image. Please try again.';
    } catch (_) {
      throw 'Could not upload image. Please try again.';
    }
  }
}
