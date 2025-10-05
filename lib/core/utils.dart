import 'package:url_launcher/url_launcher.dart';

Future<void> launchInNewTab(String url) async {
  final uri = Uri.parse(url);

  // En web: abre en una nueva pestaña
  if (!await launchUrl(
    uri,
    webOnlyWindowName: '_blank', // 👈 abre en una nueva pestaña
    mode: LaunchMode.externalApplication,
  )) {
    throw 'No se pudo abrir el enlace: $url';
  }
}

Future<void> openWhatsAppConfirmation() async {
  final phone = '528341662843'; // 🇲🇽 México +52 sin espacios
  final message = Uri.encodeComponent('¡Hola! Quiero confirmar mi asistencia');
  final url = 'https://wa.me/$phone?text=$message';

  final uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
    webOnlyWindowName: '_blank', // Abre en una nueva pestaña en Web
  )) {
    throw 'No se pudo abrir WhatsApp';
  }
}

