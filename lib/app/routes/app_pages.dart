import 'package:get/get.dart';
import 'package:super_app/features/food/presentation/screens/food_cart_screen.dart';
import 'package:super_app/features/food/presentation/screens/food_checkout_screen.dart';
import 'package:super_app/features/food/presentation/screens/food_order_tracking_screen.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_verify_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/ecommerce/bindings/ecommerce_binding.dart';
import '../../features/ecommerce/presentation/screens/cart_screen.dart';
import '../../features/ecommerce/presentation/screens/checkout_screen.dart';
import '../../features/ecommerce/presentation/screens/product_details_screen.dart';
import '../../features/ecommerce/presentation/screens/product_list_screen.dart';
import '../../features/grocery/bindings/grocery_binding.dart';
import '../../features/grocery/presentation/screens/grocery_store_list_screen.dart';
import '../../features/pharmacy/bindings/pharmacy_binding.dart';
import '../../features/pharmacy/presentation/screens/pharmacy_medicine_list_screen.dart';
import '../../shared/cart/presentation/screens/shared_cart_screen.dart';
import '../../features/food/bindings/food_binding.dart';
import '../../features/food/presentation/screens/restaurant_list_screen.dart';
import '../../features/food/presentation/screens/restaurant_menu_screen.dart';
import '../../features/ride/bindings/ride_binding.dart';
import '../../features/ride/presentation/screens/ride_booking_screen.dart';
import '../../features/ride/presentation/screens/ride_completed_screen.dart';
import '../../features/ride/presentation/screens/ride_searching_screen.dart';
import '../../features/ride/presentation/screens/ride_tracking_screen.dart';
import '../../features/courier/bindings/courier_binding.dart';
import '../../features/courier/presentation/screens/courier_booking_screen.dart';
import '../../features/courier/presentation/screens/courier_parcel_detail_screen.dart';
import '../../features/courier/presentation/screens/courier_tracking_screen.dart';
import '../../features/service/bindings/service_binding.dart';
import '../../features/service/presentation/screens/service_booking_screen.dart';
import '../../features/service/presentation/screens/service_category_screen.dart';
import '../../features/service/presentation/screens/service_provider_screen.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/main_nav/main_nav_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../shared/address/bindings/address_binding.dart';
import '../../shared/address/presentation/screens/add_address_screen.dart';
import '../../shared/address/presentation/screens/address_book_screen.dart';
import '../../shared/address/presentation/screens/map_picker_screen.dart';
import '../../shared/notification/presentation/screens/notifications_screen.dart';
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

  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
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
    GetPage(
      name: AppRoutes.mainNav,
      page: () => const MainNavScreen(),
      bindings: [HomeBinding(), WalletBinding(), ProfileBinding()],
    ),

    // ── E-commerce ──────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.ecommerce,
      page: () => const ProductListScreen(),
      binding: EcommerceBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => const ProductDetailsScreen(),
      binding: EcommerceBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      binding: EcommerceBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutScreen(),
      binding: EcommerceBinding(),
    ),
    GetPage(name: AppRoutes.cart, page: () => const SharedCartScreen()),
    GetPage(
      name: AppRoutes.groceryStoreList,
      page: () => const GroceryStoreListScreen(),
      binding: GroceryBinding(),
    ),
    GetPage(
      name: AppRoutes.pharmacyMedicineList,
      page: () => const PharmacyMedicineListScreen(),
      binding: PharmacyBinding(),
    ),
    GetPage(
      name: AppRoutes.foodRestaurantList,
      page: () => const RestaurantListScreen(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: AppRoutes.foodMenu,
      page: () => const RestaurantMenuScreen(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: AppRoutes.foodCart,
      page: () => const FoodCartScreen(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: AppRoutes.foodCheckout,
      page: () => const FoodCheckoutScreen(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: AppRoutes.foodOrderTracking,
      page: () => const FoodOrderTrackingScreen(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: AppRoutes.rideBooking,
      page: () => const RideBookingScreen(),
      binding: RideBinding(),
    ),
    GetPage(
      name: AppRoutes.rideSearchingDriver,
      page: () => const RideSearchingScreen(),
      binding: RideBinding(),
    ),
    GetPage(
      name: AppRoutes.rideTracking,
      page: () => const RideTrackingScreen(),
      binding: RideBinding(),
    ),
    GetPage(
      name: AppRoutes.rideCompleted,
      page: () => const RideCompletedScreen(),
      binding: RideBinding(),
    ),
    GetPage(
      name: AppRoutes.courierBooking,
      page: () => const CourierBookingScreen(),
      binding: CourierBinding(),
    ),
    GetPage(
      name: AppRoutes.courierParcelDetail,
      page: () => const CourierParcelDetailScreen(),
      binding: CourierBinding(),
    ),
    GetPage(
      name: AppRoutes.courierTracking,
      page: () => const CourierTrackingScreen(),
      binding: CourierBinding(),
    ),

    GetPage(
      name: AppRoutes.serviceCategory,
      page: () => const ServiceCategoryScreen(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceProvider,
      page: () => const ServiceProviderScreen(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceBooking,
      page: () => const ServiceBookingScreen(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
    ),
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
    GetPage(
      name: AppRoutes.mapPicker,
      page: () => const MapPickerScreen(),
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
