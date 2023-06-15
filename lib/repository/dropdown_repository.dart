import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/string.dart';

class DropdownRepository {
  final _db = FirebaseFirestore.instance;

  // Get dropdown (category, sorting) item from database
  Future<List<String>> getDropdownItemList(String doc) async {
    final snap = await _db.collection(DbString.DROPDOWN_COL).doc(doc).get();
    return (snap.data()?["list"] as List).map<String>((e) => e).toList();
  }
}
