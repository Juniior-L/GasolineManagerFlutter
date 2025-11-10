import 'package:atividade_prova/data/models/vehicle_model.dart';
import 'package:atividade_prova/data/repositories/base_dao.dart';
import 'package:firebase_database/firebase_database.dart';

class VehicleDao extends BaseDao {
  DatabaseReference? get _vehicleRef => childRef('vehicles');

  Future<void> save(Vehicle v) async {
    final ref = _vehicleRef;
    if (ref == null) return;
    await ref.push().set(v.toMap());
    print("✅ Abastecimento salvo para o usuário ${userId}");
  }

  Future<void> edit(String id, Vehicle v) async {
    final ref = _vehicleRef;
    if (ref == null) return;
    await ref.child(id).update(v.toMap());
    print("✏️ Abastecimento $id atualizado!");
  }

  Future<void> remove(String id) async {
    final ref = _vehicleRef;
    if (ref == null) return;
    await ref.child(id).remove();
    print("🗑️ Abastecimento $id removido!");
  }

  Future<List<Vehicle>> show() async {
    final ref = _vehicleRef;
    if (ref == null) return [];

    final snapshot = await ref.get();
    if (!snapshot.exists) return [];

    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return data.entries.map((entry) {
      final value = Map<String, dynamic>.from(entry.value);
      value['id'] = entry.key;
      return Vehicle.fromMap(value);
    }).toList();
  }

  Stream<List<Vehicle>> getVehicleStream() {
    final ref = _vehicleRef;
    if (ref == null) return const Stream.empty();

    return ref.onValue.map((event) {
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
