import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then(
      (value) => Navigator.pushNamed(context, AppRoute.LOGIN_PAGE),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.ORANGE_FE7455,
        child: Center(
          child: Text(
            AppString.APP_NAME,
            style: AppTextStyle.F28_BOLD.copyWith(
              color: AppColors.WHITE,
            ),
          ),
        ),
      ),
    );
  }
}
