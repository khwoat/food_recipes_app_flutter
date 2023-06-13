import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAuth {
  AppAuth._();

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static UserData userData = UserData.defaultValue();

  /// Get session from Shared Preference
  /// return true if found session
  static Future<bool> getUserSession() async {
    // Find User session in local storage
    final sharedPref = await SharedPreferences.getInstance();
    final userSession = sharedPref.getString(SharedPrefString.USER_SESSION);

    if (userSession != null && userSession != "") {
      userData = UserData.fromJson(jsonDecode(userSession));
      return true;
    } else {
      return false;
    }
  }

  /// Login function
  static Future<void> login(String email, String password) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = cred.user?.uid;
      final snap = await _db.collection(DbString.USERS_COL).doc(uid).get();
      userData = UserData.fromSnapshot(snap);

      // Store User session to local storage
      await sharedPref.setString(
        SharedPrefString.USER_SESSION,
        jsonEncode(userData.toJson()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthString.USER_NOT_FOUND_CODE) {
        throw (AuthString.USER_NOT_FOUND_TXT);
      } else if (e.code == AuthString.WRONG_PASS_CODE) {
        throw (AuthString.WRONG_PASS_TXT);
      }
    }
  }

  /// Logout function
  static Future<void> logout() async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setString(SharedPrefString.USER_SESSION, "");
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw (e.toString());
    }
  }

  /*
   * Register function
   */
  static Future<void> register(
    String displayName,
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserData(
        id: cred.user?.uid ?? "",
        displayName: displayName,
        email: email,
        favIds: [],
        recipeIds: [],
      );
      final newUserDoc = _db.collection(DbString.USERS_COL).doc(cred.user?.uid);
      await newUserDoc.set(user.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthString.EMAIL_INUSE_CODE) {
        throw (AuthString.EMAIL_INUSE_TXT);
      }
    }
  }
}
