import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FullScreenLoader {
  static void openLoadingDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Center(
              child: Lottie.asset('assets/load/loading.json', height: 200),
            ),
          ],
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
