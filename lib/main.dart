import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invitacion_web/core/consts.dart';
import 'package:invitacion_web/src/splash_lottie_view.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:invitacion_web/src/link_generator_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX');

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy()); // <-- sin '#'
  }

  final router = GoRouter(
    // Respeta la URL actual del navegador al arrancar en Web
    initialLocation: kIsWeb ? Uri.base.path : '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final qs = state.uri.queryParameters;
          final family  = qs['f'] ?? '';
          final allowed = int.tryParse(qs['n'] ?? '') ?? 0;
          return SplashLottieView(
          asset: "assets/envelope.json",
          overlayAsset: AppAssets.portrait1,
          family: family,
          allowed: allowed
        );
        },
      ),
      GoRoute(
        path: '/generar',
        builder: (context, state) => const LinkGeneratorView(),
      ),
    ],
  );


  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});
  final GoRouter router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "XV – Dora",
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // home: Invitation1(
      //   portada: AppAssets.landscape1Cropped,
      //   portadaMovil: AppAssets.portrait1,
      //   name: "Dora Elena Sánchez De Leija",
      //   fecha: DateTime(2025, 11, 8),
      // ),
    );
  }
}
