/// Fill these in with your own Cloudinary account details before using
/// [CloudinaryRepository]:
/// - cloudName: shown on your Cloudinary dashboard (console.cloudinary.com).
/// - uploadPreset: Settings -> Upload -> Upload presets -> add one with
///   signing mode set to "Unsigned" (required for client-side uploads
///   without exposing your API secret).
class TCloudinaryConfig {
  TCloudinaryConfig._();

  static const String cloudName = 'dfhgmkery';
  static const String uploadPreset = 'flutter_ecommerce_app';
}
