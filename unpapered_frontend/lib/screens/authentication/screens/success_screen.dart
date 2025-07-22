import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

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
                  //*-------------------------------------------------------------
                  Center(
                    child: Lottie.asset('assets/email/verify.json', width: 280),
                  ),
                  //*-------------------------------------------------------------
                  Center(
                    child: Text(
                      'Email Verified :D',
                      style: GoogleFonts.museoModerno(
                          color: const Color(0xFF043A50),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  //*-------------------------------------------------------------
                  const SizedBox(height: 4),
                  Center(
                      child: Text(
                    "Welcome aboard! You've officially passed the email verification test – brace yourself for an adventure filled with witty bots and digital wonders!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),

                  //*-------------------------------------------------------------
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      AuthenticationRepository.instance.screenRedirect();
                    },
                    child: Container(
                      width: screenSize,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF98701),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'CONTINUE',
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
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
