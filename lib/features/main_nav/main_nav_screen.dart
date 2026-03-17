import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../shared/profile/presentation/screens/profile_screen.dart';
import '../../shared/wallet/presentation/screens/wallet_screen.dart';
import '../../core/theme/app_colors.dart';

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

    return Scaffold(
      extendBody: true,
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: screens[currentIndex.value],
        ),
      ),
      bottomNavigationBar: _ModernBottomNav(currentIndex: currentIndex),
    );
  }
}

class _ModernBottomNav extends StatelessWidget {
  final RxInt currentIndex;
  const _ModernBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'home'.tr,
              currentIndex: currentIndex,
            ),
            _NavItem(
              index: 1,
              icon: Icons.account_balance_wallet_rounded,
              label: 'wallet'.tr,
              currentIndex: currentIndex,
            ),
            _NavItem(
              index: 2,
              icon: Icons.person_rounded,
              label: 'profile'.tr,
              currentIndex: currentIndex,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final RxInt currentIndex;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = currentIndex.value == index;
      return GestureDetector(
        onTap: () => currentIndex.value = index,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 26,
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
