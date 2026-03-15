/// All API endpoint paths.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Auth ─────────────────────────────────────────────────────────────────────
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String logout = '/auth/logout';

  // ── Profile ───────────────────────────────────────────────────────────────────
  static const String profile = '/profile';
  static const String updateProfile = '/profile/update';
  static const String uploadAvatar = '/profile/avatar';

  // ── Address ───────────────────────────────────────────────────────────────────
  static const String addresses = '/addresses';
  static const String addAddress = '/addresses';
  static String updateAddress(int id) => '/addresses/$id';
  static String deleteAddress(int id) => '/addresses/$id';

  // ── Wallet ────────────────────────────────────────────────────────────────────
  static const String walletBalance = '/wallet';
  static const String addMoney = '/wallet/topup';
  static const String transactions = '/wallet/transactions';

  // ── Home ─────────────────────────────────────────────────────────────────────
  static const String banners = '/home/banners';
  static const String featuredStores = '/home/featured';

  // ── E-commerce ────────────────────────────────────────────────────────────────
  static const String ecommerceCategories = '/ecommerce/categories';
  static const String ecommerceProducts = '/ecommerce/products';
  static String ecommerceProductDetails(int id) => '/ecommerce/products/$id';
  static const String ecommerceOrders = '/ecommerce/orders';
  static String ecommerceOrderDetails(int id) => '/ecommerce/orders/$id';

  // ── Grocery ───────────────────────────────────────────────────────────────────
  static const String groceryStores = '/grocery/stores';
  static String groceryProducts(int storeId) =>
      '/grocery/stores/$storeId/products';
  static const String groceryOrders = '/grocery/orders';

  // ── Pharmacy ──────────────────────────────────────────────────────────────────
  static const String pharmacyMedicines = '/pharmacy/medicines';
  static const String pharmacyPrescription = '/pharmacy/prescriptions';
  static const String pharmacyOrders = '/pharmacy/orders';

  // ── Food ─────────────────────────────────────────────────────────────────────
  static const String restaurants = '/food/restaurants';
  static String restaurantMenu(int restaurantId) =>
      '/food/restaurants/$restaurantId/menu';
  static const String foodOrders = '/food/orders';
  static String foodOrderTracking(int orderId) =>
      '/food/orders/$orderId/tracking';

  // ── Ride ─────────────────────────────────────────────────────────────────────
  static const String rideTypes = '/ride/types';
  static const String rideEstimate = '/ride/estimate';
  static const String rideRequest = '/ride/request';
  static String rideTracking(int rideId) => '/ride/$rideId/tracking';
  static String cancelRide(int rideId) => '/ride/$rideId/cancel';

  // ── Courier ───────────────────────────────────────────────────────────────────
  static const String courierEstimate = '/courier/estimate';
  static const String courierBook = '/courier/book';
  static String courierTracking(int parcelId) => '/courier/$parcelId/tracking';

  // ── On-Demand Services ────────────────────────────────────────────────────────
  static const String serviceCategories = '/services/categories';
  static String serviceProviders(int categoryId) =>
      '/services/categories/$categoryId/providers';
  static const String serviceBooking = '/services/bookings';

  // ── Notifications ─────────────────────────────────────────────────────────────
  static const String notifications = '/notifications';
  static String markNotificationRead(int id) => '/notifications/$id/read';
  static const String updateFcmToken = '/notifications/fcm-token';

  // ── Chat ──────────────────────────────────────────────────────────────────────
  static const String chatRooms = '/chat/rooms';
  static String chatMessages(int roomId) => '/chat/rooms/$roomId/messages';
  static const String sendMessage = '/chat/messages';
}
