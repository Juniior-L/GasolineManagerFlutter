import 'dart:async';

import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/data/repositories/refuel_dao.dart';
import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:flutter/material.dart';

class RefuelViewmodel extends ChangeNotifier {
  final _dao = RefuelDao();
  final _auth = AuthService();
  String? get user => _auth.getUserId();
  bool isListening = false;
  StreamSubscription? _subscription;

  List<Refuel> list = [];
  bool loading = true;

  RefuelViewmodel() {
    startListening();
    // if (user != null || user!.isNotEmpty) {
    //   _dao.getRefuelStream().listen((data) {
    //     list = data;
    //     loading = false;
    //     notifyListeners();
    //   });
    // }
  }

  // Inicia o listener de abastecimentos
  void startListening() {
    if (isListening) return; // evita duplicar
    print("🚀 Iniciando listener de abastecimentos...");

    _subscription = _dao.getRefuelStream().listen((data) {
      list = data;
      loading = false;
      notifyListeners();
    });

    isListening = true;
  }

  // Para o listener de abastecimentos
  void stopListening() {
    if (!isListening) return;
    print("🛑 Parando listener de abastecimentos...");

    _subscription?.cancel();
    _subscription = null;
    list = []; // limpa a lista pra UI também limpar
    isListening = false;
    notifyListeners();
  }

  Future<void> save(
    String vehicleId,
    double kilometers,
    String gasStation,
    double value,
    double liters,
    String date,
    String note,
  ) async {
    await _dao.save(
      Refuel(
        vehicleId: vehicleId,
        kilometers: kilometers,
        gasStation: gasStation,
        value: value,
        liters: liters,
        date: date,
        note: note,
      ),
    );
  }

  Future<void> edit(
    String id,
    String vehicleId,
    double kilometers,
    String gasStation,
    double value,
    double liters,
    String date,
    String note,
  ) async {
    await _dao.edit(
      id,
      Refuel(
        vehicleId: vehicleId,
        kilometers: kilometers,
        gasStation: gasStation,
        value: value,
        liters: liters,
        date: date,
        note: note,
      ),
    );
  }

  Future<void> remove(String id) async {
    await _dao.remove(id);
  }
}
