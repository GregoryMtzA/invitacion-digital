import 'package:flutter/material.dart';

class AppAssets {

  static final String _base = "assets/";

  static String landscape1 = "$_base/landscape_1.jpg";
  static String landscape1Cropped = "$_base/landscape_1_cropped.jpg";
  static String landscape2 = "$_base/landscape_2.jpg";
  static String landscape3 = "$_base/landscape_3.jpg";
  static String portrait1 = "$_base/portrait_1.jpg";
  static String portrait2 = "$_base/portrait_2.jpg";

  static String rosas1 = "$_base/rosas_1.png";
  static String rosas2 = "$_base/rosas_2.png";
  static String vintageCornerBorder = "$_base/vintage_corner_border.png";

}

class AppColors {
  /// Fondo principal claro (base neutra)
  static const surfaceLight = Color(0xFFFFF8F8); // Rosa muy claro pastel
  static const surfaceVariantLight = Color(0xFFFFFBFA); // Casi blanco con matiz rosado

  /// Texto y contraste
  static const onSurfaceLight = Color(0xFF1E1E1E); // Negro suave (para texto)
  static const onSurfaceGold = Color(0xFFD4AF37); // Dorado clásico (para títulos o acentos elegantes)

  /// Colores principales
  static const primary = Color(0xFFE9AFAF); // Rosa pastel suave
  static const primaryVariant = Color(0xFFE4B1AB); // Rosa empolvado, más cálido

  /// Secundarios (rose gold y complementarios)
  static const secondary = Color(0xFFB76E79); // Rose Gold principal
  static const secondaryVariant = Color(0xFFD8A7A7); // Tono intermedio para degradados

  /// Acentos (para botones o detalles sutiles)
  static const accent = Color(0xFFF7CAC9); // Rosa perla
  static const highlight = Color(0xFFFFE5B4); // Dorado pálido tipo champán

  /// Neutrales y bordes
  static const neutralLight = Color(0xFFF2E7E5); // Beige rosado para divisores o sombras
  static const neutralGrey = Color(0xFF9E9E9E); // Gris suave para textos secundarios

  /// Sombra o relieve sutil
  static const shadow = Color(0x22000000); // Transparente con sombra ligera
}

