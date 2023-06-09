import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppAuth {
  static final db = FirebaseFirestore.instance;

  /*
   * Login function
   */
  static Future<void> login(String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // final userMap = UserData(username: cred.user?.displayName ?? "", email: email, favIds: favIds, recipeIds: recipeIds);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthString.USER_NOT_FOUND_CODE) {
        throw (AuthString.USER_NOT_FOUND_TXT);
      } else if (e.code == AuthString.WRONG_PASS_CODE) {
        throw (AuthString.WRONG_PASS_TXT);
      }
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
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserData(
        displayName: displayName,
        email: email,
        favIds: [],
        recipeIds: [],
      );
      final newUserDoc = db.collection(FirestoreString.USERS_COL).doc(cred.user?.uid);
      await newUserDoc.set(user.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthString.WEAK_PASS_CODE) {
        throw(AuthString.WEAK_PASS_TXT);
      } else if (e.code == AuthString.EMAIL_INUSE_CODE) {
        throw(AuthString.EMAIL_INUSE_TXT);
      }
    }
  }
}
