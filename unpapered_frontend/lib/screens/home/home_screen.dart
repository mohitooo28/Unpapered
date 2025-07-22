import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:unpapered/screens/authentication/repository/user_controller.dart';
import 'package:unpapered/screens/home/widgets/drawer.dart';
import 'package:unpapered/screens/home/widgets/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool filePicked = false;
  String fileName = '';

  final controller = Get.put(UserController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final shakeKey = GlobalKey<ShakeWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 35, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Introduction Box -------------------------------------------
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: SvgPicture.asset(
                      'assets/home/option.svg',
                      width: 30,
                      height: 10,
                    ),
                  ),
                ),
                //! Naming  ----------------------------------------------------
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        "Hey, ",
                        style: GoogleFonts.montserratAlternates(
                            color: const Color(0xFF043A50),
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Text(
                          controller.user.value.userName,
                          style: GoogleFonts.montserratAlternates(
                              color: const Color(0xFF043A50),
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text(
                    "Let's Chat, Learn & Explore :D",
                    style: GoogleFonts.montserrat(
                        color: const Color(0xFF04709B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 100),

                //! Design  ------------------------------------------------------
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 240,
                        height: 230,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF249FD0),
                                Color(0xFF049B80),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            )),
                      ),
                    ),
                    Positioned(
                        bottom: -10,
                        right: 15,
                        child:
                            Lottie.asset('assets/home/home.json', width: 380)),
                  ],
                ),
                //! Upload PDF  --------------------------------------------------
                const SizedBox(height: 15),
                const FilePickerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
