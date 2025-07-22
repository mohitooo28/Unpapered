import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 55,
            decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8))),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: TextFormField(
            controller: emailController,
            cursorColor: const Color(0xFFF98701),
            validator: (value) {
              bool isEmailValid =
                  RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                      .hasMatch(value!);
              if (value.isEmpty) {
                return "Please Enter Your Email ID";
              } else if (!isEmailValid) {
                return "Please Enter Valid Email ID";
              }
            },
            decoration: InputDecoration(
              errorStyle: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF98701),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
              prefixIcon: const Icon(
                Iconsax.sms4,
                color: Color(0xFF043A50),
                size: 23,
              ),
              hintText: 'Email',
              hintStyle: GoogleFonts.montserrat(
                fontSize: 15,
                color: const Color(0xFF8391A1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
