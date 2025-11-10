import 'package:atividade_prova/utils/parse_utils.dart';

class Refuel {
  String? id;
  final String? vehicleId;
  double kilometers;
  String gasStation;
  double value;
  double liters;
  String date;
  String note;

  Refuel({
    this.id,
    required this.vehicleId,
    required this.kilometers,
    required this.gasStation,
    required this.value,
    required this.liters,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'kilometers': kilometers,
      'gasStation': gasStation,
      'value': value,
      'liters': liters,
      'date': date,
      'note': note,
    };
  }

  factory Refuel.fromMap(Map<String, dynamic> map) {
    return Refuel(
      id: map['id'],
      vehicleId: map['vehicleId'],
      kilometers: parseDouble(map['kilometers']),
      gasStation: map['gasStation'],
      value: parseDouble(map['value']),
      liters: parseDouble(map['liters']),
      date: map['date'],
      note: map['note'],
    );
  }
}
