import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/features/onBoarding/presentaion/views/widgets/on_boarding_texts_widget.dart';
import 'package:smart_label_software_engineering/features/onBoarding/presentaion/views/widgets/page_1.dart';
import 'package:smart_label_software_engineering/features/onBoarding/presentaion/views/widgets/page_2.dart';
import 'package:smart_label_software_engineering/features/onBoarding/presentaion/views/widgets/page_3.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/layout.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController pageController = PageController();
  int currentPage = 0;

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Future<void> onNextOrSignIn() async {
    if (currentPage == 2) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isOnBoardingFinished', true);
      navigatorAndRemove(context, Layout(), slideRightToLeft);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> onSkip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnBoardingFinished', true);
    navigatorAndRemove(context, Layout(), slideRightToLeft);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            // Images
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                scrollDirection: Axis.horizontal,
                allowImplicitScrolling: true,
                onPageChanged: onPageChanged,
                children: [
                  Page1(),
                  Page2(),
                  Page3(),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Titels
            SizedBox(
              height: 60,
              child: OnBoardingTitels(currentPage: currentPage),
            ),
            SizedBox(height: 20),
            // Dots
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                activeDotColor: primaryColor,
                dotColor: greyColor,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor),
                    ),
                    onPressed: onSkip,
                    child: Text(
                      "Skip",
                      style: TextStyles.buttonText.copyWith(fontSize: 14),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor),
                    ),
                    onPressed: onNextOrSignIn,
                    child: Text(
                      currentPage == 2 ? "Sign In" : "Next",
                      style: TextStyles.buttonText.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
