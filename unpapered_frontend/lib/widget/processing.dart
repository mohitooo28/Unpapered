import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ShowProcess {
  static void startProcessing() {
    showDialog(
      context: Get.overlayContext!,
      barrierColor: Colors.white,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset('assets/load/process.json', width: 250),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultTextStyle(
                    style: GoogleFonts.museoModerno(
                      color: const Color(0xFF043A50),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Processing your Request',
                          textAlign: TextAlign.center,
                          speed: const Duration(milliseconds: 300),
                        ),
                        TypewriterAnimatedText(
                          'Patience, Almost There',
                          textAlign: TextAlign.center,
                          speed: const Duration(milliseconds: 300),
                        ),
                        TypewriterAnimatedText(
                          'Initial Load, May Take Some Time',
                          textAlign: TextAlign.center,
                          speed: const Duration(milliseconds: 300),
                        ),
                      ],
                      totalRepeatCount: 1, // Set as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void stopProcessing() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
