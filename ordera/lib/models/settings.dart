import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static Future<void> saveColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('color', color.value);  // Save color as an integer
  }

  static Future<Color?> getColor() async {
    final prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('color');
    return colorValue != null ? Color(colorValue) : null;
  }
}
