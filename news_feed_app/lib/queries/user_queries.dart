import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as model;
import '../util/log.dart';

class UserQueries {
  static const USER = 'user';

  CollectionReference ref = FirebaseFirestore.instance.collection(USER);

  Future<model.User> getUser(String userId) async {
    try {
      log(this, 'Getting user...');
      DocumentSnapshot doc = await ref.doc(userId).get();

      if (doc.exists) {
        log(this, 'User found');
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        model.User myUser = model.User.fromJson(userData);
        return myUser;
      } else {
        log(this, 'User not found');
        throw Exception('User not found');
      }
    } catch (err) {
      log(this, 'Unable to get user. Error: $err');
      throw Exception('Unable to get user');
    }
  }

  //**
  /// Create user profile.
  /// [Params] name, userCountry, categories
  // */
  Future<dynamic> createUser(
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
      // await authUser?.reload();
      return authUser?.uid;
    } catch (err) {
      log(this, 'Unable to create user profile. Error: $err');
    }
  }
}
