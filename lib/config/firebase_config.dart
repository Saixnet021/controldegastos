import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static String get apiKey => kIsWeb
      ? const String.fromEnvironment('FIREBASE_API_KEY')
      : dotenv.env['FIREBASE_API_KEY'] ?? '';

  static String get authDomain => kIsWeb
      ? const String.fromEnvironment('FIREBASE_AUTH_DOMAIN')
      : dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';

  static String get projectId => kIsWeb
      ? const String.fromEnvironment('FIREBASE_PROJECT_ID')
      : dotenv.env['FIREBASE_PROJECT_ID'] ?? '';

  static String get storageBucket => kIsWeb
      ? const String.fromEnvironment('FIREBASE_STORAGE_BUCKET')
      : dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';

  static String get messagingSenderId => kIsWeb
      ? const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID')
      : dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';

  static String get appId => kIsWeb
      ? const String.fromEnvironment('FIREBASE_APP_ID')
      : dotenv.env['FIREBASE_APP_ID'] ?? '';
}
