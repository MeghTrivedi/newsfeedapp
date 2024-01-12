import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/components/news_feed_input_field.dart';
import 'package:news_feed_app/controllers/auth_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('')), body: _inputContent());
  }

  SingleChildScrollView _inputContent() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(children: [
        // Title
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            'Sign In',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Email
        Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: GetBuilder<AuthController>(
                builder: (ctrl) => NewsFeedInputField(
                    onChanged: (val) => !ctrl.setEmail(val),
                    hintText: 'Email'))),

        // Password
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: GetBuilder<AuthController>(
            builder: (ctrl) => NewsFeedInputField.obscure(
              onChanged: (val) => !ctrl.setPassword(val),
              hintText: 'Password',
            ),
          ),
        ),

        // Sign In Button
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GetBuilder<AuthController>(
            builder: (ctrl) => ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () => ctrl.login(),
            ),
          ),
        ),
      ]),
    );
  }
}
