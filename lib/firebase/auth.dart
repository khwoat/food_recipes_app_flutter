import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAuth {
  AppAuth._();

  static AppAuth get instance => AppAuth._();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  static UserData userData = UserData.defaultValue();

  /// Get session from Shared Preference
  /// return true if found session
  Future<bool> getUserSession() async {
    // Find User session in local storage
    final sharedPref = await SharedPreferences.getInstance();
    final userSession = sharedPref.getString(SharedPrefString.USER_SESSION);

    if (userSession != null && userSession != "") {
      userData = UserData.fromCredJson(jsonDecode(userSession));
      return true;
    } else {
      return false;
    }
  }

  /// Login function
  Future<void> login(String email, String password) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final snap =
          await _db.collection(DbString.RECIPES_COL).doc(cred.user?.uid).get();
      userData = UserData.fromCredAndSnap(cred, snap);

      // Store User session to local storage
      await sharedPref.setString(
        SharedPrefString.USER_SESSION,
        jsonEncode(userData.toCredJson()),
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
  Future<void> logout() async {
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
  Future<void> register(
    String displayName,
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userData = UserData(
        id: cred.user?.uid ?? "",
        displayName: displayName,
        email: email,
        favIds: [],
        recipeIds: [],
      );
      final newUserDoc = _db.collection(DbString.USERS_COL).doc(cred.user?.uid);
      await newUserDoc.set(userData.toJsonWithoutId());
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthString.EMAIL_INUSE_CODE) {
        throw (AuthString.EMAIL_INUSE_TXT);
      }
    }
  }
}
