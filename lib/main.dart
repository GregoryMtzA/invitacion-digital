import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invitacion_web/core/consts.dart';
import 'package:invitacion_web/src/invitation_1.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meta_seo/meta_seo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX');

  if (kIsWeb) {
    // Requerido por meta_seo 3.x
    MetaSEO().config();
    final meta = MetaSEO();
    meta.ogTitle(ogTitle: 'XV Años de Dora');
    meta.ogImage(ogImage: 'https://firebasestorage.googleapis.com/v0/b/cloudfeely-48b33.appspot.com/o/metatag.jpg?alt=media&token=32335e96-4283-495f-82f0-82bb8d00f075'); // imagen absoluta
    meta.twitterCard(twitterCard: TwitterCard.summaryLargeImage);
    meta.twitterImage(twitterImage: 'https://firebasestorage.googleapis.com/v0/b/cloudfeely-48b33.appspot.com/o/metatag.jpg?alt=media&token=32335e96-4283-495f-82f0-82bb8d00f075');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
