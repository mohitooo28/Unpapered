import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';
import 'package:unpapered/utils/network_manager.dart';
import 'package:unpapered/widget/full_loader.dart';
import 'package:unpapered/widget/loaders.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void logIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog();

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      //Login user using email & password
      final UserCredential = await AuthenticationRepository.instance
          .loginUser(email.text.trim(), password.text.trim());

      // Stop Loading
      FullScreenLoader.stopLoading();

      //Show Success Message
      Loaders.successSnackBar(
          title: 'Login Successful :D',
          message: "Welcome! We are excited to see you back again!");

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap :(', message: e.toString());
    }
  }
}
