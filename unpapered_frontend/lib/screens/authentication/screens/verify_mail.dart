import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:unpapered/screens/authentication/controllers/verify_email_controller.dart';
import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key, this.email});

  final String? email;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final controller = Get.put(EmailVerifyController());
  int resendTime = 60;
  late Timer countdownTimer;

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime--;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String timeFormat(n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*-----------------------------------------------------------
                  Center(
                    child: Lottie.asset('assets/email/email.json', width: 200),
                  ),
                  //*-----------------------------------------------------------
                  Center(
                    child: Text(
                      'Almost There :D',
                      style: GoogleFonts.museoModerno(
                          color: const Color(0xFF043A50),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  //*-----------------------------------------------------------
                  const SizedBox(height: 4),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                "Finalize your registration by clicking the confirmation link sent to your inbox at ",
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: widget.email ?? '',
                            style: GoogleFonts.montserrat(
                                color: const Color(0xFF04709B),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text:
                                ". In case you don't spot it, remember to double-check your spam folder for uninterrupted access.",
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ])),
                  ),

                  //*-----------------------------------------------------------
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.checkEmailVerificationStatus();
                    },
                    child: Container(
                      width: screenSize,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF98701),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'VERIFY',
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  //*-----------------------------------------------------------
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn’t receive any link? ',
                        style: GoogleFonts.montserrat(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: (resendTime == 0)
                            ? GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  controller.sendEmailVerification();
                                  resendTime = 60;
                                  startTimer();
                                },
                                child: Text(
                                  'Resend Link',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFF98701)),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: (resendTime != 0)
                            ? Text(
                                'Request new link in 00:${timeFormat(resendTime)}s',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              )
                            : const SizedBox(),
                      )),
                  // //*--------------------------------------------------------
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      AuthenticationRepository.instance.logOut();
                      stopTimer();
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
    );
  }
}
