import 'package:food_recipes_flutter/constants/string.dart';

class TextFieldValidator {
  static String? emailValidator(String? value) {
    const pattern =
        r'^(([^<>()\[\].,;:|\s@"]+(\.[^<>()\[\].,;:|\s@"]+)*)|(".+"))@((\[?[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}]?)|(([a-zA-Z0-9]+[a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,24}))$';
    final regExp = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return ValidatorString.FIELD_EMPTY;
    } else if (!regExp.hasMatch(value)) {
      return ValidatorString.NOT_MATCH_PATTERN;
    }
    return null;
  }
}
