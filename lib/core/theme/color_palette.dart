import 'package:flutter/material.dart';

const colorPallete = ColorPalette(
  blue: Color(0xFF00A9F7),
  darkGreen: Color(0xFF108252),
  darkGrey: Color(0xff4B4A4A),
  green: Color(0xFFECFDF3),
  lightBlue: Color(0xFF92DAF6),
  lightGrey: Color(0xff858484),
  pink: Color(0xFFF7D2D1),
  primaryBlue: Color(0xFF625DEE),
  red: Color(0xFFF60547),
);

class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    required this.blue,
    required this.darkGreen,
    required this.darkGrey,
    required this.green,
    required this.lightBlue,
    required this.lightGrey,
    required this.pink,
    required this.primaryBlue,
    required this.red,
  });

  final Color blue;
  final Color darkGreen;
  final Color darkGrey;
  final Color green;
  final Color lightBlue;
  final Color lightGrey;
  final Color pink;
  final Color primaryBlue;
  final Color red;

  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? blue,
    Color? darkGreen,
    Color? darkGrey,
    Color? green,
    Color? lightBlue,
    Color? lightGrey,
    Color? pink,
    Color? primaryBlue,
    Color? red,
  }) {
    return ColorPalette(
      blue: blue ?? this.blue,
      darkGreen: darkGreen ?? this.darkGreen,
      darkGrey: darkGrey ?? this.darkGrey,
      green: green ?? this.green,
      lightBlue: lightBlue ?? this.lightBlue,
      lightGrey: lightGrey ?? this.lightGrey,
      pink: pink ?? this.pink,
      primaryBlue: primaryBlue ?? this.primaryBlue,
      red: red ?? this.red,
    );
  }

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other is! ColorPalette) return this;
    return ColorPalette(
      blue: Color.lerp(blue, other.blue, t)!,
      darkGreen: Color.lerp(darkGreen, other.darkGreen, t)!,
      darkGrey: Color.lerp(darkGrey, other.darkGrey, t)!,
      green: Color.lerp(green, other.green, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      primaryBlue: Color.lerp(primaryBlue, other.primaryBlue, t)!,
      red: Color.lerp(red, other.red, t)!,
    );
  }
}
