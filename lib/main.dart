import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'core/controllers/language_controller.dart';
import 'core/network/api_client.dart';
import 'core/network/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: await Firebase.initializeApp();

  ApiClient.init();
  await StorageService.init();

  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Super App',
      debugShowCheckedModeBanner: false,

      // ── Theme ──────────────────────────────────────────────────────────────
      theme: AppTheme.lightTheme,

      // ── Internationalization ──────────────────────────────────────────────
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],

      // ── Routing ────────────────────────────────────────────────────────────
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),

      builder: (BuildContext context, widget) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)), child: Material(
          child: SafeArea(
            top: false, bottom: GetPlatform.isAndroid,
            child: Stack(children: [
              widget!,
            ]),
          ),
        ));
      },

      // ── Global bindings ────────────────────────────────────────────────────
      initialBinding: BindingsBuilder(() {
        Get.put(LanguageController(), permanent: true);
      }),

      // ── Snackbar defaults ──────────────────────────────────────────────────
      defaultGlobalState: false,
    );
  }
}
