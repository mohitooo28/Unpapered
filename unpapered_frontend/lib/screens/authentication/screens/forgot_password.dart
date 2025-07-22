import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unpapered/screens/authentication/controllers/forget_password_controller.dart';
import 'package:unpapered/screens/authentication/widgets/email_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final controller = Get.put(ForgotPassController());

  int resendTime = 30;
  late Timer countdownTimer;
  bool timerStarted = false;
  bool isButtonDisabled = false;

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime--;
      });
      if (resendTime < 1) {
        timer.cancel();
        setState(() {
          timerStarted = false;
          isButtonDisabled = false;
          resendTime = 30;
        });
      }
    });
    setState(() {
      timerStarted = true;
      isButtonDisabled = true;
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
    setState(() {
      timerStarted = false;
    });
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  String timeFormat(n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //*-------------------------------------------------------------

                    Text(
                      'Forgot Password :(',
                      style: GoogleFonts.museoModerno(
                          color: const Color(0xFF043A50),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                    //*-------------------------------------------------------------
                    const SizedBox(height: 4),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Enter the ",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "Email Address",
                        style: GoogleFonts.montserrat(
                            color: const Color(0xFF04709B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text:
                            " you used when you joined & we’ll send you instructions to reset your password",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ])),

                    //!-----------------------------------------------------------
                    const SizedBox(height: 28),
                    Form(
                      key: controller.forgetPasswordFormKey,
                      child: Column(
                        children: [
                          //*-------------------------------------------------------
                          EmailTextField(emailController: controller.email),
                          const SizedBox(height: 15),
                          //*-------------------------------------------------------
                        ],
                      ),
                    ),

                    //*-------------------------------------------------------------
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: isButtonDisabled
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              if (controller.forgetPasswordFormKey.currentState!
                                  .validate()) {
                                startTimer();
                                controller.sendPasswordResetLink();
                              }
                            },
                      child: Container(
                        width: screenSize,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isButtonDisabled
                              ? Colors.grey
                              : const Color(0xFFF98701),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'SEND MAIL',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //*-----------------------------------------------------------
                    const SizedBox(height: 10),
                    if (timerStarted)
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            'Request new link in 00:${timeFormat(resendTime)}s',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    //*-----------------------------------------------------------
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        controller.email.clear();
                        Get.back();
                      },
                      child: Container(
                          width: 58,
                          height: 58,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF043A50)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          )),
                    )
                    //*-----------------------------------------------------------
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
