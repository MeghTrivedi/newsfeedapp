import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text Widget For Description
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 40.0, left: 20, right: 20),
                child: Text(
                  'A verification email has been sent to ${widget.email}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: GetBuilder<AuthController>(builder: (ctrl) {
                    return ElevatedButton(
                      child: const Text('Continue'),
                      onPressed: () => ctrl.checkIfEmailVerified(),
                    );
                  }),
                ),
              ),
            ]),
      ),
    );
  }
}
