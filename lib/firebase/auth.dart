import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppAuth {
  static late AppAuth instance;
  AppAuth() {
    instance = this;
  }

  final db = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // final userMap = UserData(username: cred.user?.displayName ?? "", email: email, favIds: favIds, recipeIds: recipeIds);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStringAuth.USER_NOT_FOUND_CODE) {
        throw (AppStringAuth.USER_NOT_FOUND_TXT);
      } else if (e.code == AppStringAuth.WRONG_PASS_CODE) {
        throw (AppStringAuth.WRONG_PASS_TXT);
      }
    }
  }

  Future<void> register(
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
      final newUserDoc = db.collection(AppStringDB.USERS_COL).doc(email);
      newUserDoc.set(user.toJson().remove("email"));
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStringAuth.WEAK_PASS_CODE) {
        throw (AppStringAuth.WEAK_PASS_TXT);
      } else if (e.code == AppStringAuth.EMAIL_INUSE_CODE) {
        throw (AppStringAuth.EMAIL_INUSE_TXT);
      }
    }
  }
}
