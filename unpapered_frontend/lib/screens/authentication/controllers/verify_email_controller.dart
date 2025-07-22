import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unpapered/screens/authentication/screens/success_screen.dart';
import 'package:unpapered/screens/authentication/screens/verify_mail.dart';
import 'package:unpapered/widget/loaders.dart';

import '../repository/authentication_repository.dart';

class EmailVerifyController extends GetxController {
  static EmailVerifyController get instance => Get.find();

  final VerifyEmailPage countdown = const VerifyEmailPage();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'Verification Link Sent!',
          message:
              'Check your email for the verification link to complete the process.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap :(', message: e.toString());
    }
  }

  // Timer to Auto Redirect
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(const SuccessScreen(), transition: Transition.fade);
      }
    });
  }

  // Manually Check if Email is Verified
  checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(const SuccessScreen(), transition: Transition.fade);
    } else {}
  }
}
