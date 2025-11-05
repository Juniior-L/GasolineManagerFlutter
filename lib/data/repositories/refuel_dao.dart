import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class RefuelDao {
  final database = FirebaseDatabase.instance;
  final _auth = AuthService();

  String get user => _auth.getUserId();

  

  Future<void> save(Refuel r) async {
    final ref = database.ref('refuels').push();
    await ref.set(r.toMap());
    print("dados salvos");
  }

  Future<void> edit(String id, Refuel r) async {
    final ref = database.ref('refuels/$id');
    await ref.update(r.toMap());
    print("dados editados");
  }

  Future<void> remove(String id) async {
    final ref = database.ref('refuels/$id');
    await ref.remove();
  }

  Future<List<Refuel>> show() async {
    final ref = database.ref('refuels');
    final event = await ref.once();

    List<Refuel> list = [];

    if (event.snapshot.value != null) {
      final map = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      map.forEach((key, value) {
        final data = Map<String, dynamic>.from(value as Map);
        data['id'] = key;
        list.add(Refuel.fromMap(data));
      });
    }
    return list;
  }

  Stream<List<Refuel>> getRefuelStream() {
    final ref = database.ref('refuels');
    return ref.onValue.map((event) {
      final list = <Refuel>[];
      if (event.snapshot.value != null) {
        final map = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        map.forEach((key, value) {
          final data = Map<String, dynamic>.from(value as Map);
          data['id'] = key;
          list.add(Refuel.fromMap(data));
        });
      }
      return list;
    });
  }

  void listenData() {
    DatabaseReference ref = database.ref('refuels');
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        print('Dados atualizados: ${event.snapshot.value}');
      }
    });
  }
}
