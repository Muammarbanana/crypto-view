import 'package:crypto_view/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  ColorPalette get color => extension<ColorPalette>() ?? colorPallete;
}
