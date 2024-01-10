import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/components/news_feed_input_field.dart';

import '../controllers/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().clearInputFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _inputSignUp(),
      ),
    );
  }

  SingleChildScrollView _inputSignUp() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text('Sign Up',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GetBuilder<AuthController>(
                builder: (ctrl) => NewsFeedInputField(
                    onChanged: (val) => !ctrl.setEmail(val),
                    hintText: 'Email')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GetBuilder<AuthController>(
                builder: (ctrl) => NewsFeedInputField.obscure(
                    onChanged: (val) => !ctrl.setPassword(val),
                    hintText: 'Password')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GetBuilder<AuthController>(
                builder: (ctrl) => NewsFeedInputField.obscure(
                    onChanged: (val) => !ctrl.setConfirmPassword(val),
                    hintText: 'Confirm Password')),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GetBuilder<AuthController>(builder: (ctrl) {
                return ElevatedButton(
                    onPressed: () {
                      if (ctrl.email.isEmpty) {
                        Get.snackbar('Error', 'Please enter your email',
                            snackPosition: SnackPosition.BOTTOM);
                      } else if (!ctrl.isPasswordFieldEntered) {
                        Get.snackbar('Error', 'Please enter your password',
                            snackPosition: SnackPosition.BOTTOM);
                      } else if (!ctrl.isReEnterPasswordFieldEntered) {
                        Get.snackbar('Error', 'Please confirm your password',
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        ctrl.signUp();
                      }
                    },
                    child: const Text('Sign Up'));
              })),
        ],
      ),
    );
  }
}
