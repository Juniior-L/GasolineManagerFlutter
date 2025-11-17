import 'dart:async';

import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/data/repositories/refuel_dao.dart';
import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RefuelViewmodel extends ChangeNotifier {
  final _dao = RefuelDao();
  final _auth = AuthService();
  String? get user => _auth.getUserId();
  bool isListening = false;
  StreamSubscription? _subscription;

  List<Refuel> list = [];
  bool loading = true;

  List<Refuel> getByVehicle(String vehicleId) {
    return list.where((r) => r.vehicleId == vehicleId).toList();
  }

  RefuelViewmodel() {
    startListening();
  }

  List<FlSpot> getSpots(String vehicleId) {
    final items = getByVehicle(vehicleId);

    return items.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.value);
    }).toList();
  }

  double getTotalMonth(String vehicleId) {
    final items = getByVehicle(vehicleId);
    return items.fold(0.0, (sum, r) => sum + r.value);
  }

  List<Map<String, String>> getHistoryFormatted(String vehicleId) {
    final items = getByVehicle(vehicleId);
    return items.map((r) {
      return {
        "station": r.gasStation,
        "date": r.date,
        "value": "R\$ ${r.value.toStringAsFixed(2)}",
      };
    }).toList();
  }

  double totalKm(String? vehicleId) {
    if (vehicleId == null) return 0;
    List<Refuel> list = getByVehicle(vehicleId);
    if (list.length < 2) return 0;

    final sorted = [...list]
      ..sort((a, b) => a.kilometers.compareTo(b.kilometers));

    return sorted.last.kilometers - sorted.first.kilometers;
  }

  double avgKmPerLiter(String? vehicleId) {
    if (vehicleId == null) return 0;
    List<Refuel> list = getByVehicle(vehicleId);
    final totalLiters = list.fold(0.0, (sum, r) => sum + r.liters);
    if (totalLiters == 0) return 0;

    return totalKm(vehicleId) / totalLiters;
  }

  int totalRefuels(vehicleId) {
    if (vehicleId == null) return 0;
    List<Refuel> list = getByVehicle(vehicleId);
    return list.length;
  }

  void startListening() {
    if (isListening) return;
    _subscription = _dao.getRefuelStream().listen((data) {
      list = data;
      loading = false;
      notifyListeners();
    });

    isListening = true;
  }

  void stopListening() {
    if (!isListening) return;
    _subscription?.cancel();
    _subscription = null;
    list = [];
    isListening = false;
    notifyListeners();
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
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
