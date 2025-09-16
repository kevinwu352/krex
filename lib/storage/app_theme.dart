import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark;

  factory AppTheme.fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppTheme.light;
      case ThemeMode.dark:
        return AppTheme.dark;
      case ThemeMode.system:
        return AppTheme.light;
    }
  }
  factory AppTheme.fromBrightness(Brightness value) {
    switch (value) {
      case Brightness.light:
        return AppTheme.light;
      case Brightness.dark:
        return AppTheme.dark;
    }
  }
}

var kCurrentTheme = AppTheme.light;
