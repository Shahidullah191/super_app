class AppRoutes {
  AppRoutes._();

  // ── Splash ───────────────────────────────────────────────────────────────────
  static const String splash = '/splash';

  // ── Auth ─────────────────────────────────────────────────────────────────────
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerify = '/otp-verify';
  static const String forgotPassword = '/forgot-password';

  // ── Main Shell ───────────────────────────────────────────────────────────────
  static const String mainNav = '/main-nav';

  // ── E-commerce ──────────────────────────────────────────────────────────────
  static const String ecommerce = '/ecommerce';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String ecommerceOrderHistory = '/ecommerce-orders';
  static const String ecommerceOrderConfirmation = '/ecommerce/order-confirm';
  static const String ecommerceWishlist = '/ecommerce/wishlist';
  static const String ecommerceReviews = '/ecommerce/reviews';
  static const String ecommerceOrderDetails = '/ecommerce/order-details';
  static const String ecommerceCategories = '/ecommerce/categories';
  static const String ecommerceFlashSale = '/ecommerce/flash-sale';
  static const String ecommerceTrackOrder = '/ecommerce/track-order';

  // ── Grocery ───────────────────────────────────────────────────────────────────
  static const String groceryStoreList = '/grocery/stores';
  static const String groceryProductList = '/grocery/products';
  static const String groceryCart = '/grocery/cart';
  static const String groceryCheckout = '/grocery/checkout';
  static const String groceryProductDetails = '/grocery/product-details';
  static const String groceryOrderConfirmation = '/grocery/order-confirm';

  // ── Pharmacy ──────────────────────────────────────────────────────────────────
  static const String pharmacyMedicineList = '/pharmacy/medicines';
  static const String pharmacyMedicineDetails = '/pharmacy/medicine-details';
  static const String pharmacyUploadPrescription = '/pharmacy/prescription';
  static const String pharmacyCart = '/pharmacy/cart';
  static const String pharmacyCheckout = '/pharmacy/checkout';
  static const String pharmacyOrderConfirmation = '/pharmacy/order-confirm';

  // ── Food ─────────────────────────────────────────────────────────────────────
  static const String foodRestaurantList = '/food/restaurants';
  static const String foodMenu = '/food/menu/:id';
  static const String foodCart = '/food/cart';
  static const String foodCheckout = '/food/checkout';
  static const String foodOrderConfirmation = '/food/order-confirm';
  static const String foodOrderTracking = '/food/tracking/:id';

  // ── Ride ─────────────────────────────────────────────────────────────────────
  static const String rideBooking = '/ride/booking';
  static const String rideSearchingDriver = '/ride/searching';
  static const String rideDriverArriving = '/ride/arriving';
  static const String rideTracking = '/ride/tracking/:id';
  static const String rideCompleted = '/ride/completed';

  // ── Courier ───────────────────────────────────────────────────────────────────
  static const String courierBooking = '/courier/booking';
  static const String courierParcelDetail = '/courier/parcel/:id';
  static const String courierTracking = '/courier/tracking/:id';

  // ── On-Demand Services ────────────────────────────────────────────────────────
  static const String serviceCategory = '/service/categories';
  static const String serviceProvider = '/service/providers';
  static const String serviceBooking = '/service/booking';

  // ── Shared ────────────────────────────────────────────────────────────────────
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String addressBook = '/address/book';
  static const String addAddress = '/address/add';
  static const String mapPicker = '/address/map';
  static const String wallet = '/wallet';
  static const String addMoney = '/wallet/add';
  static const String transactionHistory = '/wallet/transactions';
  static const String notifications = '/notifications';
  static const String orderHistory = '/orders';
  static const String settings = '/settings';
  static const String helpCenter = '/help';
  static const String paymentMethods = '/payment-methods';
  static const String orderConfirmation = '/order-confirmation';
  static const String globalSearch = '/search';
  static const String chatList = '/chat';
  static const String chatDetail = '/chat/:id';
}
