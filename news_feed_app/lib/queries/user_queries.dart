import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as model;
import '../util/log.dart';

class UserQueries {
  static const USER = 'user';

  CollectionReference ref = FirebaseFirestore.instance.collection(USER);

  Future<void> createUser(
      {String? name, String? userCountry, List<String>? categories}) async {
    User? authUser = FirebaseAuth.instance.currentUser;

    model.User user = model.User(
      uid: authUser?.uid ?? '',
      email: authUser?.email ?? '',
      name: name,
      userCountry: userCountry,
      categories: categories,
    );
    try {
      log(this, 'Creating user...');
      await ref.doc(authUser?.uid).set(user.toJson());
    } catch (err) {
      log(this, 'Unable to create user profile. Error: $err');
    }
  }
}
