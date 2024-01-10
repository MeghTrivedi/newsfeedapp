import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 300,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                      pause: const Duration(milliseconds: 4000),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText('Your One Stop News App.'),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 300,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                      pause: const Duration(milliseconds: 4000),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                            'The best stories from the sources you love, selected just for you.'),
                      ]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const SignInPage());
              },
              child: const Text('Sign In'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const SignUpPage());
                },
                child: const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
