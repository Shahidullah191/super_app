import 'package:get/get.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_verify_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main_nav/main_nav_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../shared/address/bindings/address_binding.dart';
import '../../shared/address/presentation/screens/add_address_screen.dart';
import '../../shared/address/presentation/screens/address_book_screen.dart';
import '../../shared/profile/bindings/profile_binding.dart';
import '../../shared/profile/presentation/screens/edit_profile_screen.dart';
import '../../shared/profile/presentation/screens/profile_screen.dart';
import '../../shared/wallet/bindings/wallet_binding.dart';
import '../../shared/wallet/presentation/screens/add_money_screen.dart';
import '../../shared/wallet/presentation/screens/transaction_history_screen.dart';
import '../../shared/wallet/presentation/screens/wallet_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    // ── Splash ────────────────────────────────────────────────────────────────
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    // ── Auth ──────────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerify,
      page: () => const OtpVerifyScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),

    // ── Main Navigation Shell ─────────────────────────────────────────────────
    GetPage(name: AppRoutes.mainNav, page: () => const MainNavScreen()),

    // ── Home ──────────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    // ── Profile ───────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),

    // ── Address ───────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.addressBook,
      page: () => const AddressBookScreen(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => const AddAddressScreen(),
      binding: AddressBinding(),
    ),

    // ── Wallet ────────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.wallet,
      page: () => const WalletScreen(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: AppRoutes.addMoney,
      page: () => const AddMoneyScreen(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: AppRoutes.transactionHistory,
      page: () => const TransactionHistoryScreen(),
      binding: WalletBinding(),
    ),
  ];
}
