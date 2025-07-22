import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:svg_flutter/svg.dart';
import 'dart:math' as maths;

import 'package:unpapered/screens/authentication/repository/authentication_repository.dart';
import 'package:unpapered/screens/authentication/repository/user_controller.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shakeKey = GlobalKey<ShakeWidgetState>();
    final controller = UserController.instance;
    return Drawer(
      backgroundColor: const Color(0xFF043A50),
      shape: const Border.symmetric(horizontal: BorderSide.none),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 25, bottom: 30),
            child: ShakeMe(
              key: shakeKey,
              shakeCount: 3,
              shakeOffset: 3,
              shakeDuration: const Duration(milliseconds: 300),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(maths.pi),
                child: GestureDetector(
                  onLongPress: () {
                    HapticFeedback.heavyImpact();
                    shakeKey.currentState?.shake();
                  },
                  child: SvgPicture.asset(
                    'assets/logos/logo.svg',
                    height: 120,
                  ),
                ),
              ),
            ),
          ),
          listItem(Iconsax.profile_circle, controller.user.value.userName),
          listItem(Iconsax.sms, controller.user.value.email),
          listItem(Iconsax.path, 'Edit Account Details'), //! To be done
          listItem(Iconsax.lamp_slash, 'Dark Mode'), //! To be done
          listItem(Iconsax.directbox_notif, 'Sadie Chatbot'), //! To be done
          listItem(Iconsax.sms_tracking, 'Contact Us'), //! To be done
          listItem(Iconsax.people, 'About Us'), //! To be done
          listItem(Iconsax.bag_cross, 'Delete Account'), //! To be done
          const Spacer(),
          GestureDetector(
            onTap: () {
              AuthenticationRepository.instance.logOut();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 35),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.logout,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Log Out',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserratAlternates(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding listItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserratAlternates(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
