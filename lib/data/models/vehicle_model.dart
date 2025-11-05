class Vehicle {
  String? id;
  String model;
  String plate;
  String year;
  String fueltype;

  Vehicle({
    this.id,
    required this.model,
    required this.plate,
    required this.year,
    required this.fueltype,
  });

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'plate': plate,
      'year': year,
      'fueltype': fueltype,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      model: map['model'],
      plate: map['plate'],
      year: map['year'],
      fueltype: map['fueltype'],
    );
  }
}
