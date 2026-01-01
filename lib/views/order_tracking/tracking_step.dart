import 'package:flutter/material.dart';

class TrackingStep {
  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isActive,
    this.timestamp,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isActive;
  final DateTime? timestamp; // optional, for future real-time updates
}
