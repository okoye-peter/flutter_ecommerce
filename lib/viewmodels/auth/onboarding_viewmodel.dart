import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  final currentPageIndex = 0.obs;

  final List<OnboardingModel> pages = const [
    OnboardingModel(
      image: TImages.onBoarding1,
      title: TTexts.onBoardingTitle1,
      subTitle: TTexts.onBoardingSubTitle1,
    ),
    OnboardingModel(
      image: TImages.onBoarding2,
      title: TTexts.onBoardingTitle2,
      subTitle: TTexts.onBoardingSubTitle2,
    ),
    OnboardingModel(
      image: TImages.onBoarding3,
      title: TTexts.onBoardingTitle3,
      subTitle: TTexts.onBoardingSubTitle3,
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void updatePageIndicator(int index) => currentPageIndex.value = index;

  void dotNavigatorClick(int index) {
    currentPageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool get isLastPage => currentPageIndex.value == pages.length - 1;

  void nextPage() {
    currentPageIndex.value++;
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skipPage() {
    currentPageIndex.value = pages.length - 1;
    pageController.jumpToPage(pages.length - 1);
  }
}
