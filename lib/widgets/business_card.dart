import 'package:flutter/material.dart';
import '../interfaces/card_displayable.dart';

class BusinessCard<T extends CardDisplayable> extends StatelessWidget {
  final T item;
  final VoidCallback? onTap;
  final Widget? customTrailing;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  const BusinessCard({
    super.key,
    required this.item,
    this.onTap,
    this.customTrailing,
    this.margin,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: elevation ?? 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.cardIcon,
                        color: item.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.primaryTitle,
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                      ),
                    ),
                    if (customTrailing != null) customTrailing!,
                  ],
                ),
                const SizedBox(height: 12),

                // Secondary info
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.secondaryInfo,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Contact info
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.contactInfo,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: item.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Specialized widget for businesses with additional business-specific features
class BusinessSpecificCard extends BusinessCard {
  const BusinessSpecificCard({
    super.key,
    required super.item,
    super.onTap,
    super.margin,
    super.elevation,
  }) : super(
          customTrailing: const Icon(Icons.business_center, color: Colors.blue),
        );
}

/// Specialized widget for services with additional service-specific features
class ServiceSpecificCard extends BusinessCard {
  const ServiceSpecificCard({
    super.key,
    required super.item,
    super.onTap,
    super.margin,
    super.elevation,
  }) : super(
          customTrailing: const Icon(Icons.star, color: Colors.amber),
        );
}
