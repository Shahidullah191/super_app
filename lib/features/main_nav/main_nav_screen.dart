import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../shared/profile/presentation/screens/profile_screen.dart';
import '../../shared/wallet/presentation/screens/wallet_screen.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = 0.obs;

    final screens = [
      const HomeScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        body: screens[currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (i) => currentIndex.value = i,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_balance_wallet_outlined),
              activeIcon: const Icon(Icons.account_balance_wallet),
              label: 'wallet'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: 'profile'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
