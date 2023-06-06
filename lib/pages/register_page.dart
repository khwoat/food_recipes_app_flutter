import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/firebase/auth.dart';
import 'package:food_recipes_flutter/validators.dart';

import '../constants/button_style.dart';
import '../constants/string.dart';
import '../constants/text_style.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _displayNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.WHITE),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),

            // Register form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      UIString.REGISTER_HEAD,
                      style: AppTextStyle.F28_BOLD.copyWith(
                        color: AppColors.ORANGE_FE7455,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _getTextFormField(
                      context,
                      label: UIString.DISPLAYNAME_TXT_FIELD,
                      controller: _displayNameCtrl,
                    ),
                    _getTextFormField(
                      context,
                      label: UIString.EMAIL_TXT_FIELD,
                      validator: TextFieldValidator.emailValidator,
                      controller: _emailCtrl,
                    ),
                    _getTextFormField(
                      context,
                      label: UIString.PSWD_TXT_FIELD,
                      controller: _passwordCtrl,
                    ),
                    _getTextFormField(
                      context,
                      label: UIString.CONFIRM_PSWD_TXT_FIELD,
                    ),

                    const SizedBox(height: 5),

                    // Register button
                    _getButton(
                      context,
                      label: UIString.REGISTER_BTN,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await AppAuth.register(
                            _displayNameCtrl.text,
                            _emailCtrl.text,
                            _passwordCtrl.text,
                          ).then((value) => Navigator.of(context).pop());
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      buttonStyle: AppButtonStyle.ORANGE_BTN,
                    ),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: _getDivider(context),
                    ),
                    _getFacebookGoogleBtn(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getTextFormField(
    BuildContext context, {
    required String label,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
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
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _getDivider(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _getSingleDivider(context),
        Text(
          UIString.OR_DIVIDER,
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
}
