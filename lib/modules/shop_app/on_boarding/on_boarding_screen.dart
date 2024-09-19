import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salla/modules/shop_app/login/shop_login_screen.dart';
import 'package:salla/shared/network/local/cache_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              _currentPage = page;
              setState(() {});
            },
            children: [
              _buildPageContent(
                isShowImageOnTop: false,
                image: 'assets/images/onboarding1.png',
                body:
                    'Browse the menu and order directly from the application.',
                color: const Color(
                  0xFFFF7255,
                ),
              ),
              _buildPageContent(
                isShowImageOnTop: true,
                image: 'assets/images/onboarding2.png',
                body:
                    'Your order will be immediately collected and sent by our courier ',
                color: const Color(
                  0xFFFFAA66,
                ),
              ),
              _buildPageContent(
                isShowImageOnTop: false,
                image: 'assets/images/onboarding3.png',
                body: 'Pick up delivery at your door and enjoy groceries',
                color: const Color(
                  0xFF3C60AA,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width * .05,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < _totalPages; i++)
                            i == _currentPage
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false)
                        ],
                      ),
                      const Spacer(),
                      if (_currentPage != 2)
                        InkWell(
                          onTap: () {
                            _pageController.animateToPage(
                              2,
                              duration: const Duration(
                                milliseconds: 250,
                              ),
                              curve: Curves.linear,
                            );
                            setState(
                              () {},
                            );
                          },
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      if (_currentPage == 2)
                        InkWell(
                          onTap: () {
                            CacheHelper.saveData(key: 'onBoarding', value: true)
                                .then((value) {
                              if (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShopLoginScreen(),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: const Text(
                              'Start',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required String image,
    required String body,
    required Color color,
    isShowImageOnTop,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isShowImageOnTop)
            Column(
              children: [
                Center(
                  child: Image.asset(
                    image,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.6,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          if (isShowImageOnTop)
            Column(
              children: [
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24,
                      height: 1.6,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    image,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 450,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      height: isCurrentPage ? 18.0 : 10.0,
      width: isCurrentPage ? 18.0 : 10.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.white54,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
