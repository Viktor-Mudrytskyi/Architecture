# architecture_templates

fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n

fvm flutter clean
fvm flutter pub get
cd ios
pod install
cd..

spider build

bundles
example.architecture.com.dev
example.architecture.com

Architecture dev
Architecture prod

IOS Flavor set-up https://medium.com/@developerjamiu/mastering-flutter-flavors-tailoring-your-app-for-multiple-environments-92c65cd98638
Android Flavor set-up https://docs.flutter.dev/deployment/flavors

# Info

## runZonedGuarded

Is used to catch unhandled errors and exceptions that occur within a specific zone in Dart. Zones are like separate execution contexts that can have their own error handling and asynchronous behavior. By using runZonedGuarded, you can ensure that any uncaught errors in that zone are handled gracefully, which is particularly useful for logging crashes in Crashlytics.
