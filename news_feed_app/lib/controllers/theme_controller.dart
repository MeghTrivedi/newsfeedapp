import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../util/log.dart';

mixin ThemeStatic {
  static const settings = 'settings';
  static const isLightMode = 'isLightMode';
  static const isDynamicTheme = 'isDynamicTheme';
}

class ThemeController extends GetxController with _CustomColors {
  late Map<String, dynamic> settings;

  bool _isLightMode = false;
  bool get isLightMode {
    // if (IS_DEBUG_MODE) return _isLightMode;

    if (isDynamicTheme) {
      if (DateTime.now().hour > 6 && DateTime.now().hour < 18) {
        _isLightMode = true;
        return _isLightMode;
      } else {
        /// This is dark mode if it is during the night.
        _isLightMode = false;
        return _isLightMode;
      }
    }

    return _isLightMode;
  }

  StreamSubscription? _themeSubscription;

  @override
  void dispose() {
    _themeSubscription?.cancel();
    super.dispose();
  }

  void _watchTime() {
    _themeSubscription?.cancel();
    _themeSubscription = Stream.periodic(
      IS_DEBUG_MODE ? const Duration(seconds: 10) : const Duration(minutes: 1),
    ).listen((event) {
      if (IS_DEBUG_MODE) {
        _isLightMode = !_isLightMode;
        update();
        return;
      }

      log(this, 'Theme check: ${DateTime.now()}');
      if (isDynamicTheme) {
        if (DateTime.now().hour > 6 && DateTime.now().hour < 18) {
          /// This is light mode if it is during the day.
          if (!_isLightMode) {
            log(this, 'Switching to light mode');
            update();
          }

          _isLightMode = true;
        } else {
          if (_isLightMode) {
            log(this, 'Switching to dark mode');
            update();
          }

          /// This is dark mode if it is during the night.
          _isLightMode = false;
        }
      }
    });
  }

  /// Setting theme to false. Disabling for this app.
  bool _isDynamicTheme = false;
  bool get isDynamicTheme => _isDynamicTheme;

  late SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _watchTime();
  }

  void dynamicStatusBarColor() => SystemChrome.setSystemUIOverlayStyle(
      isLightMode ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light);

  Brightness statusBarBrightness() =>
      isLightMode ? Brightness.light : Brightness.dark;

  SystemUiOverlayStyle statusBarStyle() =>
      isLightMode ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;

  Map<String, dynamic> loadThemeSettings() {
    final stringJson = _prefs.getString(ThemeStatic.settings) ?? '{}';
    settings = Map<String, dynamic>.from(jsonDecode(stringJson));

    _isLightMode = settings[ThemeStatic.isLightMode] ?? false;
    _isDynamicTheme = settings[ThemeStatic.isDynamicTheme] ?? true;

    log(this, 'Loading settings: $settings');
    return settings;
  }

  Future<void> saveThemeSettings() async {
    settings[ThemeStatic.isLightMode] = isLightMode;
    settings[ThemeStatic.isDynamicTheme] = isDynamicTheme;

    log(this, 'Saving settings: $settings');
    final stringJson = jsonEncode(settings);
    await _prefs.setString(ThemeStatic.settings, stringJson);
  }

  void onToggleDynamicTheme(bool selected) {
    _isDynamicTheme = selected;
    update();
    saveThemeSettings();
  }

  void onToggleLightMode(bool selected) {
    _isLightMode = selected;
    _isDynamicTheme = false;
    update();
    saveThemeSettings();
  }

  Color backgroundColor() => isLightMode ? daylightPeach : veryDarkNavy;
  Color widgetColor() => isLightMode ? daylightDarkerPeach : darkNavy;
  Color highBackgroundColor() => isLightMode ? Colors.white : superDarkNavy;
  Color secondaryColor() => teal;
  Color secondaryBrightColor() => brightTeal;
  Color trimColor() => Colors.blue;
  Color trimBrightColor() => Colors.blueAccent;
  Color dynamicTrimColor() => isLightMode ? teal : trimColor();

  Color popupBackgroundColor() =>
      isLightMode ? backgroundColor() : widgetColor();

  Color foregroundColor({bool isDimmed = false}) => isLightMode
      ? (!isDimmed ? Colors.black : Colors.black.withOpacity(0.5))
      : (!isDimmed ? Colors.white : Colors.white.withOpacity(0.5));

  Color foregroundMediumColor() => isLightMode
      ? const Color.fromRGBO(100, 100, 100, 1)
      : const Color.fromRGBO(150, 150, 150, 1);

  Color widgetForegroundColor({bool isDimmed = false}) => isLightMode
      ? (!isDimmed ? Colors.black : Colors.black.withOpacity(0.5))
      : (!isDimmed ? Colors.white : Colors.white.withOpacity(0.5));

  LinearGradient widgetGradient() =>
      isLightMode ? primaryGradient() : darkNavyGradient();

  LinearGradient primaryGradient() => LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            darkTeal,
            darkBlue,
          ]);

  LinearGradient transparentGradient() => const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.transparent,
            Colors.transparent,
          ]);

  LinearGradient darkNavyGradient() => LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            widgetColor(),
            widgetColor(),
          ]);

  List<Color> cardShaders() => [
        Colors.black.withOpacity(0.7),
        Colors.transparent,
        Colors.black.withOpacity(0.5),
        Colors.black.withOpacity(0.9),
      ];

  List<Color> profileCoverShaders() => [
        Colors.black.withOpacity(0.75),
        for (var i = 0; i < 3; i++) Colors.transparent,
      ];
}

mixin _CustomColors {
  final darkBlue = const Color.fromRGBO(0, 120, 176, 2);
  final lightBlue = const Color(0xFF00B0FF);
  final peach = const Color(0xFFFFCD9C);
  final daylightPeach = const Color.fromRGBO(255, 251, 245, 1);
  final daylightDarkerPeach = const Color.fromRGBO(240, 235, 220, 1);
  final veryDarkNavy = const Color.fromRGBO(20, 25, 53, 1);
  final superDarkNavy = const Color.fromRGBO(10, 15, 25, 1);
  final darkNavy = const Color.fromRGBO(22, 35, 90, 1);
  final lightNavy = const Color.fromRGBO(61, 107, 235, 2);
  final teal = const Color.fromRGBO(34, 185, 163, 1);
  final darkTeal = const Color.fromRGBO(27, 150, 132, 1); //27, 150, 132, 1);
  final brightTeal = const Color.fromRGBO(112, 253, 174, 1);
}
