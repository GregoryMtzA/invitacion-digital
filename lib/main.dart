import 'package:flutter/material.dart';
import 'package:invitacion_web/core/consts.dart';
import 'package:invitacion_web/src/invitation_1.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "XV – Dora",
      debugShowCheckedModeBanner: false,
      home: Invitation1(
        portada: AppAssets.landscape1Cropped,
        portadaMovil: AppAssets.portrait1,
        name: "Dora Elena Sánchez De Leija",
        fecha: DateTime(2025, 11, 8),
      ),
    );
  }
}
