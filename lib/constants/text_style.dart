// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle BASIC_FONT = TextStyle(
    color: AppColors.DARK_GREY,
  );

  static final TextStyle F14_NORMAL = BASIC_FONT.copyWith(
    fontSize: 14,
  );

  static final TextStyle F18_NORMAL = BASIC_FONT.copyWith(
    fontSize: 18,
  );

  static final TextStyle F18_BOLD = BASIC_FONT.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle F20_NORMAL = BASIC_FONT.copyWith(
    fontSize: 20,
  );

  static final TextStyle F20_BOLD = BASIC_FONT.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle F22_NORMAL = BASIC_FONT.copyWith(
    fontSize: 22,
  );

  static final TextStyle F22_BOLD = BASIC_FONT.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle F24_BOLD = BASIC_FONT.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle F28_BOLD = BASIC_FONT.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle F30_BOLD = BASIC_FONT.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}
