import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //*-----------------------------------------------------------
        Center(
          child: SizedBox(
            height: 300,
            child: Center(
              child: Lottie.asset(
                image,
                width: screenWidth,
              ),
            ),
          ),
        ),
        // *-----------------------------------------------------------
        const SizedBox(height: 40),
        Text(
          title,
          style: GoogleFonts.montserratAlternates(
              fontSize: 36, fontWeight: FontWeight.bold),
        ),
        //*-----------------------------------------------------------
        const SizedBox(height: 6),
        Text(
          subtitle,
          style:
              GoogleFonts.montserrat(fontSize: 19, fontWeight: FontWeight.w400),
        ),
        //*-----------------------------------------------------------
      ],
    );
  }
}
