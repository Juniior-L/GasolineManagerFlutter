import 'dart:async';
import 'package:atividade_prova/data/models/vehicle_model.dart';
import 'package:atividade_prova/data/repositories/vehicle_dao.dart';
import 'package:flutter/material.dart';

class VehicleViewmodel extends ChangeNotifier {
  final _dao = VehicleDao();
  bool isListening = false;
  StreamSubscription? _subscription;

  List<Vehicle> list = [];
  bool loading = true;
  int selectedIndex = 0;

  VehicleViewmodel() {
    startListening();
  }

  Widget? get isLoading => null;

  // Aqui seleciona os veiculos por id pra mandar pro carrossel hihihiha
  void nextVehicle() {
    if (list.isEmpty) return;
    selectedIndex = (selectedIndex + 1) % list.length;
    notifyListeners();
  }

  void previousVehicle() {
    if (list.isEmpty) return;
    selectedIndex = (selectedIndex - 1 + list.length) % list.length;
    notifyListeners();
  }

  Vehicle? get selectedVehicle {
    if (list.isEmpty) return null;
    return list[selectedIndex];
  }

  Vehicle? vehicleModel(String vehicleId) {
    if (list.isEmpty) return null;
    for (var v in list) {
      if (v.id == vehicleId) return v;
    }
    return null;
  }

  // Aqui o trampo dos inferno q eu tive pra fazer o login n travar qnd da logout
  void startListening() {
    if (isListening) return;
    _subscription = _dao.getVehicleStream().listen((data) {
      list = data;
      if (selectedIndex >= list.length) {
        selectedIndex = list.isEmpty ? 0 : list.length - 1;
      }
      loading = false;
      notifyListeners();
    });

    isListening = true;
  }

  void stopListening() {
    if (!isListening) return;
    list.clear();
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
    String model,
    String plate,
    String year,
    String fueltype,
  ) async {
    await _dao.save(
      Vehicle(model: model, plate: plate, year: year, fueltype: fueltype),
    );
  }

  Future<void> edit(
    String id,
    String model,
    String plate,
    String year,
    String fueltype,
  ) async {
    await _dao.edit(
      id,
      Vehicle(model: model, plate: plate, year: year, fueltype: fueltype),
    );
  }

  Future<void> remove(String id) async {
    await _dao.remove(id);
  }
}
