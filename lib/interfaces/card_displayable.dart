import 'package:flutter/material.dart';

/// Interface for objects that can be displayed in a card
abstract class CardDisplayable {
  String get primaryTitle;
  String get secondaryInfo;
  String get contactInfo;
  IconData get cardIcon;
  Color get primaryColor;
}
