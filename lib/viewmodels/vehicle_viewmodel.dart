import 'package:atividade_prova/data/models/vehicle_model.dart';
import 'package:atividade_prova/data/repositories/vehicle_dao.dart';
import 'package:flutter/material.dart';

class VehicleViewmodel extends ChangeNotifier {
  final _dao = VehicleDao();

  List<Vehicle> list = [];
  bool loading = true;

  VehicleViewmodel() {
    _dao.getVehicleStream().listen((data) {
      list = data;
      loading = false;
      notifyListeners();
    });
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
