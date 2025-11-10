import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:atividade_prova/ui/pages/home_page.dart';
import 'package:atividade_prova/ui/pages/login_page.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final refuelVM = Provider.of<RefuelViewmodel>(context, listen: false);
          final vehicleVM = Provider.of<VehicleViewmodel>(
            context,
            listen: false,
          );
          refuelVM.startListening();
          vehicleVM.startListening();
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
