# Multi-Service Super App – Requirements Analysis & Implementation Plan

> **Scope: Customer App only** · SRS v1.1 · Flutter / Laravel / PostgreSQL · March 2026
> Vendor, Rider, and Driver apps are **out of scope** — to be built as separate projects in the future.

---

## 1. Requirements Analysis Summary

### 1.1 In-Scope: Customer App

| Capability | Description |
|---|---|
| Authentication | Mobile number + OTP, password reset |
| Home Dashboard | Service grid, banners, search, location |
| E-commerce | Browse products, cart, checkout, order history |
| Grocery | Store listing, product browsing, time-slot delivery |
| Pharmacy | Medicine search, prescription upload, checkout |
| Food Delivery | Restaurant discovery, menu, cart, live order tracking |
| Ride Sharing | Pickup/drop, fare estimate, driver tracking |
| Courier | Parcel booking, price estimate, parcel tracking |
| On-Demand Services | Electrician / Plumber / Cleaner / AC Repair booking |
| Profile | Edit profile, preferences |
| Address Book | Multiple saved addresses, map picker |
| Wallet | Balance, add money, transaction history |
| Payments | COD, Wallet, Card |
| Notifications | Push (FCM) + in-app notification feed |
| Chat | Customer ↔ Vendor / Driver / Rider / Support |
| Maps & Location | Google Maps, geolocator, route tracking |

### 1.2 Out of Scope (This App)

- Vendor panel (catalog/order management) → **future separate app**
- Delivery Rider app → **future separate app**
- Driver app → **future separate app**
- Admin panel → **future separate project**
- Web customer portal
- B2B / enterprise flows
- Internationalization beyond local language + English

### 1.3 Service Domains vs. Real-Time Tracking

| # | Domain | Live Tracking? |
|---|---|---|
| 1 | E-commerce | ❌ (status updates) |
| 2 | Grocery | ❌ |
| 3 | Pharmacy | ❌ |
| 4 | Food Delivery | ✅ |
| 5 | Ride Sharing | ✅ |
| 6 | Courier | ✅ |
| 7 | On-Demand Services | ❌ |

### 1.4 Functional Requirements (Customer-Facing)

| FR-ID | Requirement |
|---|---|
| FR-001 | Register and login via mobile number + OTP |
| FR-002 | Browse all service domains from a single home dashboard |
| FR-003 | Search and filter products/services per module |
| FR-004 | Add to cart and checkout (COD / Wallet / Card) |
| FR-005 | Track order/ride/courier status in real time |
| FR-009 | Receive push + in-app notifications for key events |
| FR-010 | View wallet balance and full transaction history |

### 1.5 Non-Functional Requirements

| Area | Target |
|---|---|
| Cold launch | < 3 seconds |
| API p95 response | < 500 ms |
| Authentication | JWT Bearer over HTTPS only |
| Lists | Paginated |
| Images | Cached (`cached_network_image`) |
| Error states | Graceful with retry |
| Scalability | Multi-city, multi-vendor backend |

---

## 2. Architecture Design

### 2.1 Folder Structure – Feature-Based Clean Architecture

```
lib/
├── main.dart
├── app/
│   ├── app.dart                    # Root widget + GetMaterialApp
│   └── routes/
│       ├── app_routes.dart         # Named route constants
│       └── app_pages.dart          # GetPage list with bindings
├── core/
│   ├── network/
│   │   ├── api_client.dart         # Dio singleton + interceptors
│   │   └── api_endpoints.dart      # All endpoint constants
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── utils/
│   │   ├── constants.dart
│   │   ├── validators.dart
│   │   └── extensions.dart
│   └── widgets/                    # Reusable UI components
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── loading_widget.dart
│       └── error_widget.dart
├── features/
│   ├── auth/
│   ├── home/
│   ├── ecommerce/
│   ├── grocery/
│   ├── pharmacy/
│   ├── food/
│   ├── ride/
│   ├── courier/
│   └── service/                    # On-demand services
└── shared/
    ├── profile/
    ├── address/
    ├── wallet/
    ├── payment/
    ├── notification/
    ├── chat/
    └── cart/
```

Each feature follows:
```
feature/
  data/
    models/          # JSON-serializable data models
    repositories/    # API call methods
  presentation/
    controllers/     # GetxController (reactive state)
    screens/         # UI screens
    widgets/         # Feature-local widgets
  bindings/          # GetX dependency injection
```

### 2.2 State Management: GetX
- Controllers extend `GetxController` with `.obs` reactive variables
- `Bindings` injected at route level — lazy-loaded
- Repositories injected via `Get.find<>()`

### 2.3 Network Layer
- **Dio** with `AuthInterceptor` (auto-attaches Bearer token)
- Centralized error handling (`DioException → AppException`)
- Standard response envelope from backend:
```json
{ "status": true, "message": "success", "data": {} }
```

---

## 3. Phased Delivery Roadmap

| Phase | Deliverables | Approx. Screens |
|---|---|---|
| **1** | Foundation + Auth + Profile + Address + Wallet + Home | ~25 |
| **2** | E-commerce + Grocery + Pharmacy + Payment + Cart | ~35 |
| **3** | Food Delivery (live order tracking) | ~20 |
| **4** | Courier (parcel tracking) | ~15 |
| **5** | Ride Sharing (live tracking) | ~20 |
| **6** | On-Demand Services + Notifications + Chat | ~25 |
| **Total** | **Customer App** | **~140 screens** |

---

## 4. Verification Plan

### Per Phase – Static Analysis
```bash
flutter analyze
```
Target: **0 errors, 0 warnings**

### Per Phase – Build Check
```bash
flutter build apk --debug
```

### Per Phase – Manual UI Verification
1. `flutter run` on emulator/device
2. Navigate all new screens — verify layout and navigation
3. Check API calls via Dio logging interceptor
4. Test error states: disable network → verify graceful fallback UI
