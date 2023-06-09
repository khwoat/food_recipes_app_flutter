import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/button_style.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/firebase/auth.dart';
import 'package:food_recipes_flutter/route.dart';
import 'package:food_recipes_flutter/validators.dart';
import 'package:food_recipes_flutter/widgets/app_snack_bar.dart';

import '../widgets/app_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTxtCtrl = TextEditingController();
  final _passTxtCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                UIString.APP_NAME_NEW_LINE,
                textAlign: TextAlign.center,
                style: AppTextStyle.F28_BOLD.copyWith(
                  color: AppColors.ORANGE_FE7455,
                  fontFamily: "Forte",
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

  Widget _getTextFormField(
    BuildContext context, {
    required String label,
    TextEditingController? controller,
    String? Function(String? value)? validator,
    TextInputType? keyboardType,
    bool? obscureText,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        label: Text(label),
        labelStyle: AppTextStyle.F20_BOLD.copyWith(
          color: AppColors.LIGHT_GREY,
        ),
        floatingLabelStyle: AppTextStyle.F20_NORMAL.copyWith(
          color: AppColors.ORANGE_FE7455,
        ),
        enabledBorder: normalFieldBorder(),
        errorBorder: normalFieldBorder(),
        focusedBorder: focusedFieldBorder(),
        focusedErrorBorder: focusedFieldBorder(),
      ),
    );
  }

  // Normal field
  OutlineInputBorder normalFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColors.LIGHT_GREY,
        width: 2,
      ),
    );
  }

  // Focused field
  OutlineInputBorder focusedFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColors.ORANGE_FE7455,
        width: 2,
      ),
    );
  }

  // Login form (by email and password)
  Widget _getEmailPswdForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _getTextFormField(
            context,
            label: UIString.EMAIL_TXT_FIELD,
            controller: _emailTxtCtrl,
            validator: TextFieldValidator.emailValidator,
          ),
          const SizedBox(height: 10),
          _getTextFormField(
            context,
            label: UIString.PSWD_TXT_FIELD,
            controller: _passTxtCtrl,
            validator: TextFieldValidator.passwordValidator,
            obscureText: true,
          ),
          const SizedBox(height: 15),
          // Login btn
          _getButton(
            context,
            label: UIString.LOGIN_BTN,
            buttonStyle: AppButtonStyle.ORANGE_BTN,
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                try {
                  await AppAuth.login(
                    _emailTxtCtrl.text,
                    _passTxtCtrl.text,
                  ).then((value) {
                    Navigator.of(context).popAndPushNamed(
                      AppRoute.HOME_PAGE,
                    );
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar.build(titleText: e.toString()),
                  );
                }
              }
            },
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
          UIString.OR_DIVIDER,
          style: AppTextStyle.F20_BOLD.copyWith(
            color: AppColors.MED_GREY,
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
      color: AppColors.LIGHT_GREY,
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
          label: UIString.FACEBOOK_BTN,
          buttonStyle: AppButtonStyle.BLUE_BTN,
          onTap: () {},
        ),

        const SizedBox(height: 10),

        // Google btn
        _getButton(
          context,
          label: UIString.GOOGLE_BTN,
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
          UIString.DIDNT_HAVE_ANY_ACC_TXT,
          style: AppTextStyle.F20_BOLD.copyWith(
            color: AppColors.MED_GREY,
          ),
        ),

        const SizedBox(height: 5),

        // Register text btn
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoute.REGISTER_PAGE),
          child: Text(
            UIString.REGISTER_TXT_BTN,
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
