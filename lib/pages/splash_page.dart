import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/firebase/auth.dart';
import 'package:food_recipes_flutter/route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppAuth _appAuth = AppAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000)).then(
      (value) async {
        await _appAuth.getUserSession().then((value) {
          Navigator.of(context).pushReplacementNamed(
            value ? AppRoute.HOME_PAGE : AppRoute.LOGIN_PAGE,
          );
        });
      },
    );

    return Scaffold(
      body: Container(
        color: AppColors.ORANGE_FE7455,
        child: Center(
          child: Text(
            UIString.APP_NAME_NEW_LINE,
            textAlign: TextAlign.center,
            style: AppTextStyle.F30_BOLD.copyWith(
              color: AppColors.WHITE,
              fontFamily: "Forte",
            ),
          ),
        ),
      ),
    );
  }
}
