import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/pages/email_verification_page.dart';
import 'package:news_feed_app/pages/landing_page.dart';

import '../config/current_state.dart';
import '../models/user.dart' as model;
import '../pages/create_profile_page.dart';
import '../pages/home_page.dart';
import '../queries/user_queries.dart';
import '../util/log.dart';

class AuthController extends GetxController {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  late final authState = CurrentState(() => update());
  late final emailState = CurrentState(() => update());
  late final verifyEmailState = CurrentState(() => update());

  String get email => _email.text.trim();

  User? _user;
  UserCredential? _userCredential;
  bool get isPasswordFieldEntered => _password.text.isNotEmpty;
  bool get isReEnterPasswordFieldEntered => _confirmPassword.text.isNotEmpty;

  bool setEmail(String email) {
    _email.text = email.trim();

    /// Check if email is valid regex format.
    if (RegExp(
            r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  bool setConfirmPassword(String password) {
    _confirmPassword.text = password.trim();

    /// Password must be at least 6 characters long.
    if (password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  bool setPassword(String password) {
    _password.text = password.trim();

    /// Password must be at least 6 characters long.
    if (password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    clearInputFields();
    _email.clear();
    _password.clear();
    super.dispose();
  }

  void clearInputFields() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _email.clear();
      _password.clear();
      _confirmPassword.clear();
      update();
    });
  }

  Future<void> init() async {
    emailState.asOk();
    verifyEmailState.asOk();

    _user = FirebaseAuth.instance.currentUser;

    try {
      await _user?.reload();
    } catch (err) {
      log(this, 'Failed to reload User. Error: $err');
    }

    if (_user != null) {
      clearInputFields();
      model.User? userData;
      try {
        log(this, '_user!.uid: ${_user!.uid}');
        userData = await UserQueries().getUser(_user!.uid);
      } catch (err) {
        authState.asOk();
        log(this, 'Failed to get user. Error: $err');
      }

      // Check if user data exists
      if (userData != null) {
        model.User.me = userData;
        authState.asOk();
        Get.offAll(() => const HomePage());
      } else {
        // check if email is verified
        if (_user?.emailVerified ?? false) {
          authState.asOk();
          Get.offAll(() => const CreateProfilePage());
        } else {
          if (_user?.email == null) {
            authState.asOk();
            log(this, 'User email is null');
          } else {
            authState.asOk();
            Get.offAll(() => EmailVerificationPage(email: _user?.email));
          }
        }
      }
    } else {
      clearInputFields();
      authState.asOk();
      Get.offAll(() => const LandingPage());
      log(this, 'Auth Controller, user is not signed in');
    }
  }

  Future<void> checkIfEmailVerified() async {
    verifyEmailState.asLoading();

    _user = FirebaseAuth.instance.currentUser;
    // requires two fetches for some reason
    // fetch one
    try {
      await _user?.reload();
    } catch (err) {
      log(this, 'Failed to reload User. Error: $err');
    }
    // fetch two
    try {
      await _user?.reload();
    } catch (err) {
      log(this, 'Failed to reload User. Error: $err');
    }

    if (_user?.emailVerified ?? false) {
      verifyEmailState.refresh(StateAs.ok);
      Get.offAll(() => const CreateProfilePage());
    } else {
      log(this, 'Users email is not verified');
      Get.snackbar('Verify Email',
          'Please verify your email. It may take a few minutes for the email to be verified. ');
    }
  }

  Future<void> signUp() async {
    try {
      if (_confirmPassword.text != _password.text) {
        // throw Exception('Passwords do not match');
        Get.snackbar('Error', 'The passwords do not match');
        return;
      }
      authState.refresh(StateAs.loading);

      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text.trim());

      _user = _userCredential?.user ?? FirebaseAuth.instance.currentUser;

      try {
        _user?.reload();
        await _user?.sendEmailVerification();
      } catch (e) {
        log(this, 'Failed to reload User. Error: $e');
      }

      clearInputFields();

      await init();
    } catch (err) {
      Get.back();
      log(this, 'Failed to sign up. Error: $err');
    }
    authState.refresh(StateAs.ok);
  }

  Future<void> login() async {
    try {
      authState.refresh(StateAs.loading);
      log(this, 'Logging in...');
      _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      if (_userCredential?.user?.uid == null) {
        throw Exception('Could not get user. User may not exist');
      }
      log(this, 'Email: ${_email.text.trim()}');
      clearInputFields();
      update();
      await init();
    } catch (err) {
      log(this, 'Failed to login. Error: $err');
    }
    authState.refresh(StateAs.ok);
  }
}
