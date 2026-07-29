# ecommerce

A Flutter e-commerce app: browse products by category/brand, manage a cart, check out, track
orders, and manage a profile — backed by Firebase.

## Tech stack

- **State management**: [Riverpod 3](https://riverpod.dev) — some controllers use `riverpod_generator`
  code generation (`@riverpod`), others use the classic manual syntax (`Notifier`/`AsyncNotifier`
  extended directly). Both styles coexist in this codebase.
- **Routing**: [go_router](https://pub.dev/packages/go_router), with auth/onboarding-aware
  redirects (`lib/core/router/app_router.dart`).
- **Backend**: Firebase (Auth, Cloud Firestore).
- **Image hosting**: Cloudinary, for user- and admin-uploaded images (e.g. category seeding).

## Project structure

```
lib/
  core/         # router, theming, constants, shared widgets, DI providers, utils
  models/       # plain data classes (Firestore document <-> Dart mapping)
  repositories/ # Firebase/Cloudinary access, one per domain (auth, category, banner, ...)
  viewmodels/   # Riverpod controllers/notifiers, one per feature
  views/        # screens and widgets, organized by feature (auth, products, cart, ...)
  scripts/      # one-off dev utilities (e.g. Firestore category seeding)
```

## Getting started

1. **Install dependencies**

   ```sh
   flutter pub get
   ```

2. **Generate code** — some controllers (e.g. `lib/viewmodels/banners/banner_controller.dart`)
   use `riverpod_generator` and need their `.g.dart` part files built:

   ```sh
   dart run build_runner build --delete-conflicting-outputs
   ```

   Re-run this (or `dart run build_runner watch`) whenever you add/edit an `@riverpod`
   annotated provider. Generated `.g.dart` files are committed to the repo, so this step
   isn't required just to run the app — only when you change a codegen source file.

3. **Firebase**: `lib/firebase_options.dart` is already checked in (generated via
   `flutterfire configure`). If you're pointing this app at your own Firebase project,
   regenerate it with the FlutterFire CLI and drop in your own
   `google-services.json` / `GoogleService-Info.plist` (these are gitignored).

4. **Cloudinary**: fill in your own account details in
   `lib/core/config/cloudinary_config.dart` before using any upload-dependent features
   (e.g. `lib/scripts/category_seeder.dart`).

5. **Seed sample data** — a fresh Firebase project has an empty `Products`/`Categories`/
   `Banners` collection, so most screens will look empty until you seed them. Run the app,
   sign in, then go to **Profile → Upload Data** (`/profile/upload_data`) and tap, in order:

   1. **Upload Categories** — products reference category doc IDs, so this has to run first.
   2. **Upload Products** — includes a handful of "variable" products (multiple attributes/
      variations) for exercising that flow.
   3. **Upload Banners** — independent of the other two, any order is fine.

   This is safe to re-run any time — the seeders use deterministic document IDs, so
   re-uploading overwrites the same documents instead of duplicating them. (The "Upload
   Brands" and "...Relation Data" tiles on that screen aren't implemented yet — brand data
   is embedded directly in each product document by the product seeder.)

6. **Run the app**

   ```sh
   flutter run
   ```

## Useful resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Riverpod documentation](https://riverpod.dev/)
- [go_router documentation](https://pub.dev/packages/go_router)
