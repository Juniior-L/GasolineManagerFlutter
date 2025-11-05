import 'package:atividade_prova/data/models/vehicle_model.dart';
import 'package:firebase_database/firebase_database.dart';

class VehicleDao {
  final database = FirebaseDatabase.instance;

  Future<void> save(Vehicle v) async {
    final ref = database.ref('vehicles').push();
    await ref.set(v.toMap());
    print("dados salvos");
  }

  Future<void> edit(String id, Vehicle v) async {
    final ref = database.ref('vehicles/$id');
    await ref.update(v.toMap());
    print("dados editados");
  }

  Future<void> remove(String id) async {
    final ref = database.ref('vehicles/$id');
    await ref.remove();
    print("Dado removido");
  }

  Future<List<Vehicle>> show() async {
    final ref = database.ref('vehicles');
    final event = await ref.once();

    List<Vehicle> list = [];

    if (event.snapshot.value != null) {
      final map = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      map.forEach((key, value) {
        final data = Map<String, dynamic>.from(value as Map);
        data['id'] = key;
        list.add(Vehicle.fromMap(data));
      });
    }
    return list;
  }

  Stream<List<Vehicle>> getVehicleStream() {
    final ref = database.ref('vehicles');
    return ref.onValue.map((event) {
      final list = <Vehicle>[];
      if (event.snapshot.value != null) {
        final map = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        map.forEach((key, value) {
          final data = Map<String, dynamic>.from(value as Map);
          data['id'] = key;
          list.add(Vehicle.fromMap(data));
        });
      }
      return list;
    });
  }

  void listenData() {
    DatabaseReference ref = database.ref('vehicles');
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        print('Dados atualizados: ${event.snapshot.value}');
      }
    });
  }
}
