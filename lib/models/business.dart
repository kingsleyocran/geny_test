import 'package:flutter/material.dart';
import '../interfaces/card_displayable.dart';

class Business implements CardDisplayable {
  final String bizName;
  final String bssLocation;
  final String contactNo;

  const Business({
    required this.bizName,
    required this.bssLocation,
    required this.contactNo,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      bizName: json['biz_name'] as String,
      bssLocation: json['bss_location'] as String,
      contactNo: json['contct_no'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biz_name': bizName,
      'bss_location': bssLocation,
      'contct_no': contactNo,
    };
  }

  @override
  String get primaryTitle => bizName;

  @override
  String get secondaryInfo => bssLocation;

  @override
  String get contactInfo => contactNo;

  @override
  IconData get cardIcon => Icons.business;

  @override
  Color get primaryColor => Colors.blue;

  @override
  String toString() {
    return 'Business(bizName: $bizName, bssLocation: $bssLocation, contactNo: $contactNo)';
  }
}
