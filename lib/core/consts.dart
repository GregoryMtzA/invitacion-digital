import 'package:flutter/material.dart';

class AppAssets {

  static final String _base = "assets/";

  static String landscape1 = "$_base/landscape_1.jpg";
  static String landscape1Cropped = "$_base/landscape_1_cropped.jpg";
  static String landscape2 = "$_base/landscape_2.jpg";
  static String landscape3 = "$_base/landscape_3.jpg";
  static String portrait1 = "$_base/portrait_1.jpg";
  static String portrait2 = "$_base/portrait_2.jpg";
  static String landscape2CropVertical = "$_base/landscape_2 crop_vert.jpg";

  static String rosas1 = "$_base/rosas_1.png";
  static String rosas2 = "$_base/rosas_2.png";
  static String vintageCornerBorder = "$_base/vintage_corner_border.png";
  static String dressCode = "$_base/dress_code.png";
  static String gift = "$_base/gift.png";
  static String envelope = "$_base/envelope.json";
  static String camera = "$_base/camera.png";

}

class AppColors {
  /// Fondo principal claro (base neutra)
  static const surfaceLight = Color(0xFFFFF8F8); // Rosa muy claro pastel
  static const surfaceVariantLight = Color(0xFFFFFBFA); // Casi blanco con matiz rosado

  /// Texto y contraste
  static const onSurfaceLight = Color(0xFF1E1E1E); // Negro suave (para texto)
  static const onSurfaceGold = Color(0xFFefb810); // Dorado clásico (para títulos o acentos elegantes)

  /// Colores principales
  static const rosaPastel = Color(0xFFFADADD); // Beige rosado para divisores o sombras
  static const roseGold = Color(0xFFB76E79); // Beige rosado para divisores o sombras
  /// Acentos (para botones o detalles sutiles)

  /// Neutrales y bordes
  static const neutralLight = Color(0xFFF2E7E5); // Beige rosado para divisores o sombras
  static const neutralGrey = Color(0xFF9E9E9E); // Gris suave para textos secundarios
}

