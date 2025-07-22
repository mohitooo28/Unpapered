import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unpapered/screens/authentication/screens/login_page.dart';
import 'package:unpapered/screens/on_boarding/model.dart';
import 'package:unpapered/screens/on_boarding/onboarding_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool showBtn = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    setState(() {
                      _pageController.animateToPage(3,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    });
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.mavenPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF8D8D8D)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //----------------------------------------------------------------
              Expanded(
                  child: PageView.builder(
                controller: _pageController,
                itemCount: onBoardData.length,
                onPageChanged: (index) {
                  currentPage = index;
                  setState(() {});
                },
                itemBuilder: (context, index) => OnBoardingWidget(
                    image: onBoardData[index].image,
                    title: onBoardData[index].title,
                    subtitle: onBoardData[index].subtitle),
              )),
              //----------------------------------------------------------------
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: const Color(0xFF043A50),
                        dotHeight: 6,
                        dotColor: const Color(0xFF043A50).withOpacity(0.6)),
                  ),
                  const Spacer(),
                  //---------
                  const SizedBox(width: 5),
                  //---------
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      if (currentPage != 2) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      } else {
                        final storage = GetStorage();
                        storage.write('isFirstTime', false);
                        Get.offAll(() => const LoginPage(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 200));
                      }
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: (currentPage == 2) ? 160 : 58,
                        height: 58,
                        decoration: BoxDecoration(
                            color: const Color(0xFF043A50),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: (currentPage == 2)
                              ? FutureBuilder<bool>(
                                  future: Future.delayed(
                                      const Duration(milliseconds: 200), () => true),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Text('Get Started',
                                          style:
                                              GoogleFonts.montserratAlternates(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ));
                                    } else {
                                      return Container();
                                    }
                                  })
                              : const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
