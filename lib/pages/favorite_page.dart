import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/string.dart';
import '../constants/text_style.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ORANGE_FE7455,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          AppString.FAVORITE_PAGE,
          textAlign: TextAlign.center,
          style: AppTextStyle.F24_BOLD.copyWith(
            color: AppColors.WHITE,
          ),
        ),
      ),
    );
  }
}
