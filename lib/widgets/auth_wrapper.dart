import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthViewModel>().authStateChanges,
      builder: (context, snapshot) {
        // Mostrar indicador de carga mientras se verifica el estado de autenticación
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF1744)),
              ),
            ),
          );
        }

        // Si hay un usuario autenticado, mostrar HomeScreen
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Si no hay usuario autenticado, mostrar LoginScreen
        return const LoginScreen();
      },
    );
  }
}
