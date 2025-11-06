import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class RefuelDao {
  final _database = FirebaseDatabase.instance.ref();
  final _auth = AuthService();

  String get _userId => _auth.getUserId();

  DatabaseReference get _userRef =>
      _database.child('users').child(_userId).child('refuels');

  Future<void> save(Refuel refuel) async {
    await _userRef.push().set(refuel.toMap());
    print(" Abastecimento salvo para usuário $_userId");
  }

  Future<void> edit(String id, Refuel refuel) async {
    await _userRef.child(id).update(refuel.toMap());
  }

  Future<void> remove(String id) async {
    await _userRef.child(id).remove();
  }

  Future<List<Refuel>> show() async {
    final snapshot = await _userRef.get();
    if (!snapshot.exists) return [];

    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return data.entries.map((entry) {
      final value = Map<String, dynamic>.from(entry.value);
      value['id'] = entry.key;
      return Refuel.fromMap(value);
    }).toList();
  }

  Stream<List<Refuel>> getRefuelStream() {
    return _userRef.onValue.map((event) {
      if (event.snapshot.value == null) return [];
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data.entries.map((entry) {
        final value = Map<String, dynamic>.from(entry.value);
        value['id'] = entry.key;
        return Refuel.fromMap(value);
      }).toList();
    });
  }
}
