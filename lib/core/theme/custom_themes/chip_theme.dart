import 'package:ecommerce/core/constants/colors.dart';
import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: TColors.grey.withAlpha(102),
    labelStyle: TextStyle(color: TColors.black),
    selectedColor: TColors.primary,
    padding: const EdgeInsets.all(12),
    checkmarkColor: TColors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: TColors.darkGrey,
    labelStyle: TextStyle(color: TColors.white),
    selectedColor: TColors.primary,
    padding: const EdgeInsets.all(12),
    checkmarkColor: TColors.white,
  );
}