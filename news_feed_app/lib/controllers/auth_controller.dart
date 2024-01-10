import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../config/current_state.dart';
// import '../models/user.dart' as model;
import '../pages/create_profile_page.dart';
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
          Get.offAll(() => const CreateProfilePage());
        }
      }
    }
  }

  Future<void> signUp() async {
    try {
      if (_confirmPassword.text != _password.text) {
        throw Exception('Passwords do not match');
      }
      print('1');
      authState.refresh(StateAs.loading);
      print(_email.text);
      print(_password.text);

      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text.trim());
      print('2');

      _user = _userCredential?.user ?? FirebaseAuth.instance.currentUser;
      print('3');

      try {
        _user?.reload();
        await _user?.sendEmailVerification();
      } catch (e) {
        log(this, 'Failed to reload User. Error: $e');
      }
      print('4');

      clearInputFields();
      print('5');

      await init();
      print('6');
    } catch (err) {
      Get.back();
      log(this, 'Failed to sign up. Error: $err');
    }
    authState.refresh(StateAs.ok);
  }
}
