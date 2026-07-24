import 'dart:io';
import 'dart:typed_data';

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

      return await _upload(formData);
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map ? (data['error']?['message'] as String?) : null;
      throw message ?? 'Could not upload image. Please try again.';
    } catch (_) {
      throw 'Could not upload image. Please try again.';
    }
  }

  /// Same as [uploadImage], but for in-memory bytes — e.g. bundled Flutter
  /// assets loaded via `rootBundle`, which don't exist as a `dart:io File`
  /// on a device's filesystem.
  Future<String> uploadBytes(Uint8List bytes, String filename) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: filename),
        'upload_preset': TCloudinaryConfig.uploadPreset,
      });

      return await _upload(formData);
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map ? (data['error']?['message'] as String?) : null;
      throw message ?? 'Could not upload image. Please try again.';
    } catch (_) {
      throw 'Could not upload image. Please try again.';
    }
  }

  Future<String> _upload(FormData formData) async {
    final response = await _dio.post(
      'https://api.cloudinary.com/v1_1/${TCloudinaryConfig.cloudName}/image/upload',
      data: formData,
    );
    return response.data['secure_url'] as String;
  }
}
