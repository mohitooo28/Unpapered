import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';
import 'package:unpapered/widget/full_loader.dart';

import '../../../utils/network_manager.dart';
import '../../../widget/loaders.dart';

class ForgotPassController extends GetxController {
  static ForgotPassController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetLink() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog();

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Send Mail to Reset Password
      await AuthenticationRepository.instance.resetPassword(email.text.trim());

      // Stop Loading
      FullScreenLoader.stopLoading();

      //Show Success Message
      Loaders.successSnackBar(
          title: 'Link Sent :D',
          message:
              'Password reset link sent. Please check your email inbox for further instructions.');
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap :(', message: e.toString());
    }
  }

  resendPasswordResetLink(String email) async {
    try {
      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      await AuthenticationRepository.instance.resetPassword(email);

      //Show Success Message
      Loaders.successSnackBar(title: 'Password Reset Link Sent');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap :(', message: e.toString());
    }
  }
}
