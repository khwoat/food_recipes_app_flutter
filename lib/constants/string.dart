// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class UIString {
  UIString._();

  static const String APP_NAME = "Food Recipes";
  static const String APP_NAME_NEW_LINE = "Food\nRecipes";

  static const String NOTIFICATION_PAGE = "Notifications";
  static const String FAVORITE_PAGE = "Favorite";

  // Label of text fields
  static const String USERNAME_TXT_FIELD = "Username";
  static const String EMAIL_TXT_FIELD = "Email";
  static const String PSWD_TXT_FIELD = "Password";
  static const String CONFIRM_PSWD_TXT_FIELD = "Confirm Password";

  static const String DIDNT_HAVE_ANY_ACC_TXT = "Didn't have any account?";
  static const String REGISTER_TXT_BTN = "Register";

  static const String OR_DIVIDER = "OR";

  static const String LOGIN_BTN = "Login";
  static const String REGISTER_BTN = "Register";
  static const String FACEBOOK_BTN = "Facebook";
  static const String GOOGLE_BTN = "Google";

  static const String REGISTER_HEAD = "Register";

  static const String FAV_HEADER = "Your Favorites";
  static const String NOTFICATION_HEADER = "Notifications";
  static const String USER_RECIPES_HEADER = "Your recipes";

  static const String SETTING_DRAWER = "Setting";
  static const String LOGOUT_DRAWER = "Logout";
}

class AuthString {
  // For Login
  static const String USER_NOT_FOUND_CODE = "user-not-found";
  static const String USER_NOT_FOUND_TXT = "User not found";
  static const String WRONG_PASS_CODE = "wrong-password";
  static const String WRONG_PASS_TXT = "Wrong password";

  // For Register
  static const String WEAK_PASS_CODE = "weak-password";
  static const String WEAK_PASS_TXT = "Weak password";
  static const String EMAIL_INUSE_CODE = "email-already-in-use";
  static const String EMAIL_INUSE_TXT = "Email is already in use";
}

class FirestoreString {
  // Collection
  static const String USERS_COL = "users";

  static const String RECIPES_COL = "recipes";
  static const String DETAIL_RECIPE_COL = "detailList";
}

class ValidatorString {
  ValidatorString._();

  static const String FIELD_EMPTY = "Please enter this field.";
  static const String INVALID_PATTERN = "Incorrect patern or letters.";
  static String INVALID_LENGTH(int min, int max) =>
      "Password must in range $min - $max.";
  static const String PASSWORD_NOT_MATCH =
      "Comfirm password does not match with password.";
}
