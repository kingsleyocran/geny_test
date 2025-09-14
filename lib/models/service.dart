import 'package:flutter/material.dart';
import '../interfaces/card_displayable.dart';

class Service implements CardDisplayable {
  final String serviceName;
  final String category;
  final String provider;
  final String contactNo;
  final double price;

  const Service({
    required this.serviceName,
    required this.category,
    required this.provider,
    required this.contactNo,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['service_name'] as String,
      category: json['category'] as String,
      provider: json['provider'] as String,
      contactNo: json['contact_no'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_name': serviceName,
      'category': category,
      'provider': provider,
      'contact_no': contactNo,
      'price': price,
    };
  }

  @override
  String get primaryTitle => serviceName;

  @override
  String get secondaryInfo => '$category • \$${price.toStringAsFixed(2)}';

  @override
  String get contactInfo => contactNo;

  @override
  IconData get cardIcon => Icons.design_services;

  @override
  Color get primaryColor => Colors.green;

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  @override
  String toString() {
    return 'Service(serviceName: $serviceName, category: $category, provider: $provider, contactNo: $contactNo, price: $price)';
  }
}
