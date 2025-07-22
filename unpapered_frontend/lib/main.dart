import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unpapered/bindings/general_bindings.dart';
import 'package:unpapered/firebase_options.dart';
import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';

void main() async {
  // * Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // * Getx Local Storage
  await GetStorage.init();

  // * Await Splash Screen Until Other Items are Loaded
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // * Delay for 2 seconds before transitioning to MyApp
  await Future.delayed(const Duration(milliseconds: 250));

  // * Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Unpapered',
      theme: ThemeData(
        primaryColor: const Color(0xFFF98701),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF98701)),
        textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Color(0xFFF98701)),
      ),
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}
