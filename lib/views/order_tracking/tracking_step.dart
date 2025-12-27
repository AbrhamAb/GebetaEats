import 'package:flutter/material.dart';

class TrackingStep {
  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isActive,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isActive;
}
