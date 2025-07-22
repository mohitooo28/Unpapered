import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

class Loaders {
  // ! Error -------------------------------------------------------------------
  static errorSnackBar({required title, message = ''}) {
    final overlayContext = Get.overlayContext;
    if (overlayContext != null) {
      final snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 4),
        content: SnackDesign(
          context: overlayContext,
          title: title,
          message: message,
          conColor: const Color(0xFFC72C41),
          svgColor: const Color(0xFF801336),
          bubbleIcon: Icons.close_rounded,
        ),
      );
      ScaffoldMessenger.of(overlayContext).showSnackBar(snackBar);
    }
  }

  // ! -------------------------------------------------------------------------
  // ? Warning -----------------------------------------------------------------
  static warningSnackBar({required title, message = ''}) {
    final overlayContext = Get.overlayContext;
    if (overlayContext != null) {
      final snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 4),
        content: SnackDesign(
          context: overlayContext,
          title: title,
          message: message,
          conColor: const Color(0xFFB8A605),
          svgColor: const Color(0xFF826500),
          bubbleIcon: Icons.error_outline,
        ),
      );
      ScaffoldMessenger.of(overlayContext).showSnackBar(snackBar);
    }
  }

  // ? -------------------------------------------------------------------------
  // * Success -----------------------------------------------------------------
  static successSnackBar({required title, message = ''}) {
    final overlayContext = Get.overlayContext;
    if (overlayContext != null) {
      final snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 3),
        content: SnackDesign(
          context: overlayContext,
          title: title,
          message: message,
          conColor: const Color(0xFF009329),
          svgColor: const Color(0xFF005513),
          bubbleIcon: Icons.check_rounded,
        ),
      );
      ScaffoldMessenger.of(overlayContext).showSnackBar(snackBar);
    }
  }
  // * -------------------------------------------------------------------------
}

class SnackDesign extends StatelessWidget {
  SnackDesign({
    super.key,
    required this.context,
    required this.title,
    required this.message,
    required this.conColor,
    required this.svgColor,
    required this.bubbleIcon,
  });

  final BuildContext? context;
  String title, message;
  Color conColor, svgColor;
  IconData bubbleIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: conColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
              'assets/popup/bubbles.svg',
              height: 48,
              width: 40,
              color: svgColor,
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/popup/fail.svg',
                height: 40,
                color: svgColor,
              ),
              Positioned(
                top: 10,
                child: Icon(bubbleIcon, size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
