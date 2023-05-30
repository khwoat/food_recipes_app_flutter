import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/button_style.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/route.dart';

import '../widgets/app_card.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.ORANGE_FE7455,
      appBar: AppBar(toolbarHeight: 0.0),
      body: Center(
        child: AppCard(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppString.APP_NAME_NEW_LINE,
                textAlign: TextAlign.center,
                style: AppTextStyle.F28_BOLD.copyWith(
                  color: AppColors.ORANGE_FE7455,
                ),
              ),
              _getEmailPswdForm(context),
              _getDivider(context),
              _getFacebookGoogleBtn(context),
              _getRegisterModule(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextFormField(BuildContext context, String label) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        label: Text(label),
        labelStyle: AppTextStyle.F20_BOLD.copyWith(
          color: AppColors.GREY_LIGHT,
        ),
        floatingLabelStyle: AppTextStyle.F20_NORMAL.copyWith(
          color: AppColors.ORANGE_FE7455,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.GREY_LIGHT,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.ORANGE_FE7455,
            width: 2,
          ),
        ),
      ),
    );
  }

  // Login form (by email and password)
  Widget _getEmailPswdForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          _getTextFormField(context, AppString.EMAIL_TXT_FIELD),
          const SizedBox(height: 10),
          _getTextFormField(context, AppString.PSWD_TXT_FIELD),
          const SizedBox(height: 15),
          // Login btn
          _getButton(
            context,
            label: AppString.LOGIN_BTN,
            buttonStyle: AppButtonStyle.ORANGE_BTN,
            onTap: () => Navigator.popAndPushNamed(
              context,
              AppRoute.HOME_PAGE,
            ),
          ),
        ],
      ),
    );
  }

  // "OR" Divider
  Widget _getDivider(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _getSingleDivider(context),
        Text(
          AppString.OR_DIVIDER,
          style: AppTextStyle.F20_BOLD.copyWith(
            color: AppColors.GREY_MED,
          ),
        ),
        _getSingleDivider(context),
      ],
    );
  }

  Widget _getSingleDivider(BuildContext context) {
    return Container(
      width: 90,
      height: 3,
      color: AppColors.GREY_LIGHT,
    );
  }

  Widget _getButton(
    BuildContext context, {
    required String label,
    required Function() onTap,
    required ButtonStyle buttonStyle,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Center(
        child: Text(
          label,
        ),
      ),
    );
  }

  Widget _getFacebookGoogleBtn(BuildContext context) {
    return Column(
      children: [
        // Facebook btn
        _getButton(
          context,
          label: AppString.FACEBOOK_BTN,
          buttonStyle: AppButtonStyle.BLUE_BTN,
          onTap: () {},
        ),

        const SizedBox(height: 10),

        // Google btn
        _getButton(
          context,
          label: AppString.GOOGLE_BTN,
          buttonStyle: AppButtonStyle.WHITE_BTN,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _getRegisterModule(BuildContext context) {
    return Column(
      children: [
        Text(
          AppString.DIDNT_HAVE_ANY_ACC_TXT,
          style: AppTextStyle.F20_BOLD.copyWith(
            color: AppColors.GREY_MED,
          ),
        ),

        const SizedBox(height: 5),

        // Register text btn
        InkWell(
          onTap: () {},
          child: Text(
            AppString.REGISTER_TXT_BTN,
            style: AppTextStyle.F20_BOLD.copyWith(
              shadows: [
                const Shadow(
                  color: AppColors.ORANGE_FE7455,
                  offset: Offset(0, -3),
                )
              ],
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.ORANGE_FE7455,
              decorationThickness: 2,
            ),
          ),
        ),
      ],
    );
  }
}
