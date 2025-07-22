
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math' as maths;
import 'package:svg_flutter/svg_flutter.dart';
import 'package:unpapered/Screens/authentication/controllers/login_controller.dart';
import 'package:unpapered/Screens/authentication/screens/forgot_password.dart';
import 'package:unpapered/Screens/authentication/screens/signup_page.dart';
import 'package:unpapered/Screens/authentication/widgets/email_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LogInController());

  final shakeKey = GlobalKey<ShakeWidgetState>();

  bool _passwordVisible = false;

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*-------------------------------------------------------------
                  ShakeMe(
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
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  //*-------------------------------------------------------------
                  const SizedBox(height: 15),
                  Text(
                    'Login',
                    style: GoogleFonts.museoModerno(
                        color: const Color(0xFF043A50),
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  //*-------------------------------------------------------------
                  const SizedBox(height: 5),
                  Text(
                    'Welcome Back :)',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  //*-------------------------------------------------------------
                  Text(
                    'Let\'s Get Back Chatting with PDFs!',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  //!-------------------------------------------------------------
                  const SizedBox(height: 28),
                  Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        //*-------------------------------------------------------
                        EmailTextField(emailController: controller.email),
                        const SizedBox(height: 10),
                        //*-------------------------------------------------------
                        Stack(
                          children: [
                            Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFC4C4C4).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8))),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: TextFormField(
                                controller: controller.password,
                                cursorColor: const Color(0xFFF98701),
                                obscureText: !_passwordVisible,
                                maxLength: 10,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Password";
                                  } else if (controller.password.text.length <
                                      6) {
                                    return "Password Length Should be at least 6";
                                  }
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  errorStyle: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFF98701),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  prefixIcon: const Icon(
                                    Iconsax.password_check4,
                                    color: Color(0xFF043A50),
                                    size: 23,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: const Color(0xFF8391A1),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _passwordVisible
                                          ? Iconsax.eye_slash4
                                          : Iconsax.eye,
                                      color: const Color(0xFF8391A1),
                                      size: 23,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //*-------------------------------------------------------
                      ],
                    ),
                  ),
                  //!-------------------------------------------------------------
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordPage(),
                            transition: Transition.fade);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: const Color(0xFF8391A1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  //*-------------------------------------------------------------
                  const SizedBox(height: 60),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.logIn();
                      }
                    },
                    child: Container(
                      width: screenSize,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF98701),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  //*-------------------------------------------------------------
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.off(() => const SignUpPage(),
                          transition: Transition.size,
                          duration: const Duration(milliseconds: 200));
                    },
                    child: Container(
                      width: screenSize,
                      height: 50,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: const Color(0xFFF98701), width: 1.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'CREATE ACCOUNT',
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: const Color(0xFFF98701),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  //*-------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
