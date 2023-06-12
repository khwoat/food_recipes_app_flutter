import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

class AppSnackBar {
  AppSnackBar._();

  static SnackBar build({
    required String titleText,
    Widget? leadingIcon,
    Color? backgroundColor,
  }) {
    return SnackBar(
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          leadingIcon ?? Container(),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              titleText,
              style: AppTextStyle.F18_BOLD.copyWith(
                color: AppColors.WHITE,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
