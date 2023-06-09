import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/string.dart';

class TextFieldValidator {
  TextFieldValidator._();

  static String? usernameValidator(String? value) {
    const pattern = r'[a-z]|[A-Z]|\s';
    final regExp = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return ValidatorString.FIELD_EMPTY;
    } else if (!regExp.hasMatch(value)) {
      return ValidatorString.INVALID_PATTERN;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    const pattern =
        r'^(([^<>()\[\].,;:|\s@"]+(\.[^<>()\[\].,;:|\s@"]+)*)|(".+"))@((\[?[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}]?)|(([a-zA-Z0-9]+[a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,24}))$';
    final regExp = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return ValidatorString.FIELD_EMPTY;
    } else if (!regExp.hasMatch(value)) {
      return ValidatorString.INVALID_PATTERN;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidatorString.FIELD_EMPTY;
    } else {
      if (value.length < 6 || value.length > 20) {
        return ValidatorString.INVALID_LENGTH(6, 20);
      }
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    TextEditingController _passCtrl,
  ) {
    if (value == null || value.trim().isEmpty) {
      return ValidatorString.FIELD_EMPTY;
    } else if (value != _passCtrl.text) {
      return ValidatorString.PASSWORD_NOT_MATCH;
    }
    return null;
  }
}
