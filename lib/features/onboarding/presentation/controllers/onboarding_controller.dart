import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/network/storage_service.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: 'Welcome to Super App',
      description:
          'Everything you need, all in one place. Food, Grocery, Rides, and more.',
      image:
          'https://images.unsplash.com/photo-1512428559087-560fa5ceab42?q=80&w=2070&auto=format&fit=crop',
    ),
    OnboardingData(
      title: 'Fast Delivery',
      description: 'Get your items delivered to your doorstep in no time.',
      image:
          'https://images.unsplash.com/photo-1586880244406-556ebe35f282?q=80&w=1974&auto=format&fit=crop',
    ),
    OnboardingData(
      title: 'Safe Rides',
      description:
          'Book a ride with our verified drivers for a safe and comfortable journey.',
      image:
          'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?q=80&w=2070&auto=format&fit=crop',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  void completeOnboarding() async {
    await StorageService.setSeenOnboarding();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}
