// lib/viewmodels/auth_viewmodel.dart
import 'dart:async';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? currentUser;
  bool isLoading = false;
  StreamSubscription<User?>? _authSub;

  AuthViewModel() {
    // Inscreve para atualizações de autenticação
    _authSub = _authService.userChanges.listen((user) {
      currentUser = user;
      notifyListeners();
    });

    // Inicializa currentUser imediatamente (caso já esteja logado)
    currentUser = _authService.currentUser;
  }

  // login retorna o usuário pra facilitar lógica na UI se quiser
  Future<User?> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.signInWithEmailPassword(email, password);
      currentUser = user;
      return user;
    } on FirebaseAuthException catch (e) {
      // repassa a exception pro UI para mostrar mensagem apropriada
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> register(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.createUserWithEmailPassword(
        email,
        password,
      );
      currentUser = user;
      return user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> signOut() async {
  //   currentUser = null;
  //   await _authService.signOut();
  //   notifyListeners();
  // }

  Future<void> signOut(BuildContext context) async {
    try {
      // Para o stream de abastecimentos antes de sair
      final refuelVM = Navigator.of(context).mounted
          ? context.read<RefuelViewmodel>()
          : null;
      // Para o stream de veiculos antes de sair
      refuelVM?.stopListening();
      final vehicleVM = Navigator.of(context).mounted
          ? context.read<VehicleViewmodel>()
          : null;

      refuelVM?.stopListening();
      vehicleVM?.stopListening();

      currentUser = null;
      await _authService.signOut();
      notifyListeners();

      print("✅ Logout realizado e stream encerrado!");
    } catch (e) {
      print("Erro ao deslogar: $e");
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
