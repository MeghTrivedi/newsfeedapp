import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/queries/user_queries.dart';

import '../config/current_state.dart';
import '../pages/home_page.dart';
import '../util/log.dart';

class CreateProfileController extends GetxController {
  final name = TextEditingController();
  final country = TextEditingController();
  final List<String> categories = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  late final createState = CurrentState(() => update());

  bool setName(String name) {
    this.name.text = name.trim();

    /// Name must be at least 2 characters long.
    if (name.length >= 2) {
      return true;
    } else {
      return false;
    }
  }

  bool setCountry(String country) {
    this.country.text = country.trim();

    /// Country must be at least 2 characters long.
    if (country.length >= 2) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createProfile(List<String> selected) async {
    try {
      createState.refresh(StateAs.loading);
      log(this, 'Creating profile...');

      log(this, 'Creating user profile...');
      await UserQueries().createUser(
          name: name.text, userCountry: country.text, categories: selected);

      Get.offAll(() => HomePage());
    } catch (err) {
      log(this, 'Unable to create profile. Error: $err');
      Get.snackbar('Error', 'Could not create profile');
    }
    createState.refresh(StateAs.ok);
  }
}
