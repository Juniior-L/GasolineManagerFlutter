import 'package:atividade_prova/data/models/vehicle_model.dart';
import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class VehicleDao {
  final _database = FirebaseDatabase.instance.ref();
  final _auth = AuthService();

  String get _userId => _auth.getUserId();

  // users → userId → vehicles
  DatabaseReference get _userRef =>
      _database.child('users').child(_userId).child('vehicles');

  Future<void> save(Vehicle v) async {
    await _userRef.push().set(v.toMap());
    print("✅ Veículo salvo para usuário $_userId");
  }

  Future<void> edit(String id, Vehicle v) async {
    await _userRef.child(id).update(v.toMap());
  }

  Future<void> remove(String id) async {
    await _userRef.child(id).remove();
  }

  Future<List<Vehicle>> show() async {
    final snapshot = await _userRef.get();
    if (!snapshot.exists) return [];

    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return data.entries.map((entry) {
      final value = Map<String, dynamic>.from(entry.value);
      value['id'] = entry.key;
      return Vehicle.fromMap(value);
    }).toList();
  }

  Stream<List<Vehicle>> getVehicleStream() {
    return _userRef.onValue.map((event) {
      if (event.snapshot.value == null) return [];
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data.entries.map((entry) {
        final value = Map<String, dynamic>.from(entry.value);
        value['id'] = entry.key;
        return Vehicle.fromMap(value);
      }).toList();
    });
  }
}
