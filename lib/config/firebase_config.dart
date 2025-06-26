import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static String get apiKey =>
      const String.fromEnvironment('FIREBASE_API_KEY', defaultValue: '') != ''
      ? const String.fromEnvironment('FIREBASE_API_KEY')
      : dotenv.env['FIREBASE_API_KEY'] ?? '';

  static String get authDomain =>
      const String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: '') !=
          ''
      ? const String.fromEnvironment('FIREBASE_AUTH_DOMAIN')
      : dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';

  static String get projectId =>
      const String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: '') !=
          ''
      ? const String.fromEnvironment('FIREBASE_PROJECT_ID')
      : dotenv.env['FIREBASE_PROJECT_ID'] ?? '';

  static String get storageBucket =>
      const String.fromEnvironment(
            'FIREBASE_STORAGE_BUCKET',
            defaultValue: '',
          ) !=
          ''
      ? const String.fromEnvironment('FIREBASE_STORAGE_BUCKET')
      : dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';

  static String get messagingSenderId =>
      const String.fromEnvironment(
            'FIREBASE_MESSAGING_SENDER_ID',
            defaultValue: '',
          ) !=
          ''
      ? const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID')
      : dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';

  static String get appId =>
      const String.fromEnvironment('FIREBASE_APP_ID', defaultValue: '') != ''
      ? const String.fromEnvironment('FIREBASE_APP_ID')
      : dotenv.env['FIREBASE_APP_ID'] ?? '';
}
