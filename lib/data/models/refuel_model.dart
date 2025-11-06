class Refuel {
  String? id;
  // final String? vehicleId;
  String gasStation;
  double value;
  double liters;
  String date;

  Refuel({
    this.id,
  
    required this.gasStation,
    required this.value,
    required this.liters,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'gasStation': gasStation,
      'value': value,
      'liters': liters,
      'date': date,
    };
  }

  factory Refuel.fromMap(Map<String, dynamic> map) {
    return Refuel(
      id: map['id'],
      gasStation: map['gasStation'],
      value: map['value'],
      liters: map['liters'],
      date: map['date'],
    );
  }
}
