import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends Notifier<int> {
  late final PageController pageController;

  static const List<OnboardingModel> pages = [
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
  int build() {
    pageController = PageController();
    ref.onDispose(pageController.dispose);
    return 0;
  }

  void updatePageIndicator(int index) => state = index;

  void dotNavigatorClick(int index) {
    state = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool get isLastPage => state == pages.length - 1;

  void nextPage() {
    state++;
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skipPage() {
    state = pages.length - 1;
    pageController.jumpToPage(pages.length - 1);
  }
}

final onboardingProvider = NotifierProvider.autoDispose<OnboardingNotifier, int>(
  OnboardingNotifier.new,
);
