import 'package:flutter/material.dart';
import 'app.dart';
import 'app_state.dart';
import '/services/supabase_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required for async initialization

  // Initialize Supabase
  await SupabaseService.init();

  // Test the connection
  await SupabaseService.testConnection();

  // Create a single instance of AppState
  final appState = AppState();

  // Run the app with AppStateScope
  runApp(AppStateScope(notifier: appState, child: const GebetaeatsApp()));
}
