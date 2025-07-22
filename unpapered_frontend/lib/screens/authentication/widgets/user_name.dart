import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    super.key,
    required this.userController,
  });

  final TextEditingController userController;

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
            controller: userController,
            textCapitalization: TextCapitalization.words,
            maxLength: 12,
            cursorColor: const Color(0xFFF98701),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your Username";
              } else if (RegExp(r"\s").hasMatch(value.trim())) {
                return "Username Cannot Contain Spaces";
              }
            },
            decoration: InputDecoration(
              counterText: "",
              errorStyle: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF98701),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
              prefixIcon: const Icon(
                Iconsax.user4,
                color: Color(0xFF043A50),
                size: 23,
              ),
              hintText: 'Username',
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
