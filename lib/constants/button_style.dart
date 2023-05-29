// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_style.dart';

class AppButtonStyle {
  AppButtonStyle._();

  static final ButtonStyle BASIC_BUTTON = ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
    textStyle: const MaterialStatePropertyAll(AppTextStyle.F24_BOLD),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );

  static final ButtonStyle ORANGE_BTN = BASIC_BUTTON.copyWith(
    backgroundColor: const MaterialStatePropertyAll(AppColors.ORANGE_FE7455),
    foregroundColor: const MaterialStatePropertyAll(AppColors.WHITE),
  );

  static final ButtonStyle BLUE_BTN = BASIC_BUTTON.copyWith(
    backgroundColor: const MaterialStatePropertyAll(AppColors.BLUE_1A76F2),
    foregroundColor: const MaterialStatePropertyAll(AppColors.WHITE),
  );

  static final ButtonStyle WHITE_BTN = BASIC_BUTTON.copyWith(
    backgroundColor: const MaterialStatePropertyAll(AppColors.WHITE),
    foregroundColor: const MaterialStatePropertyAll(AppColors.GREY_797979),
  );
}
