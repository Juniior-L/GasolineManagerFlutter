import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/data/repositories/refuel_dao.dart';
import 'package:flutter/material.dart';

class RefuelViewmodel extends ChangeNotifier {
  final _dao = RefuelDao();

  List<Refuel> list = [];
  bool loading = true;

  RefuelViewmodel() {
    _dao.getRefuelStream().listen((data) {
      list = data;
      loading = false;
      notifyListeners();
    });
  }

  Future<void> save(
    String gasStation,
    double value,
    double liters,
    String date,
  ) async {
    await _dao.save(
      Refuel(gasStation: gasStation, value: value, liters: liters, date: date),
    );
  }

  Future<void> edit(
    String id,
    String gasStation,
    double value,
    double liters,
    String date,
  ) async {
    await _dao.edit(
      id,
      Refuel(gasStation: gasStation, value: value, liters: liters, date: date),
    );
  }

  Future<void> remove(String id) async {
    await _dao.remove(id);
  }
}
