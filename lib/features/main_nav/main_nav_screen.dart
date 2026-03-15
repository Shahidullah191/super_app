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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
