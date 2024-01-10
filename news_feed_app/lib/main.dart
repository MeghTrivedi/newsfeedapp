import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/controller_bindings.dart';
import 'package:news_feed_app/firebase_options.dart';
import 'package:news_feed_app/pages/landing_page.dart';

/// Debug mode. Used for showing logs,
/// developer settings.
const bool IS_DEBUG_MODE =
    String.fromEnvironment("DEBUG") == 'true' ? true : false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ControllerBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Daily News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(),
        navigatorObservers: [routeObserver],
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const LandingPage()),
          // GetPage(name: '/signin', page: )
          // GetPage(name: '/news', page: () => const NewsPage()),
        ]);
  }
}
