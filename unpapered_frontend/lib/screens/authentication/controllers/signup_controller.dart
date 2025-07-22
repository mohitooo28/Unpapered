import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';
import 'package:unpapered/screens/authentication/repository/user_model.dart';
import 'package:unpapered/screens/authentication/repository/user_repository.dart';
import 'package:unpapered/screens/authentication/screens/verify_mail.dart';
import 'package:unpapered/utils/network_manager.dart';
import 'package:unpapered/widget/full_loader.dart';
import 'package:unpapered/widget/loaders.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signUp() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog();

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      //Register User in Firebase
      final UserCredential = await AuthenticationRepository.instance
          .registerUser(email.text.trim(), password.text.trim());

      //Save user data in FireStore
      final newUser = UserModel(
          id: UserCredential.user!.uid,
          userName: userName.text.trim(),
          email: email.text.trim());

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Stop Loading
      FullScreenLoader.stopLoading();

      //Show Success Message
      Loaders.successSnackBar(
          title: 'Registration Successful :D',
          message:
              "Exciting news! Your registration is complete. Get ready to embark on your digital journey!");

      //Move to verify Email Screen
      Get.to(() => VerifyEmailPage(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap :(', message: e.toString());
    }
  }
}
