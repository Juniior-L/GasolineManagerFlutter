import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/data/repositories/base_dao.dart';
import 'package:firebase_database/firebase_database.dart';

class RefuelDao extends BaseDao {
  DatabaseReference? get _refuelRef => childRef('refuels');

  Future<void> save(Refuel refuel) async {
    final ref = _refuelRef;
    if (ref == null) return;
    await ref.push().set(refuel.toMap());
    print("✅ Abastecimento salvo para o usuário ${userId}");
  }

  Future<void> edit(String id, Refuel refuel) async {
    final ref = _refuelRef;
    if (ref == null) return;
    await ref.child(id).update(refuel.toMap());
    print("✏️ Abastecimento $id atualizado!");
  }

  Future<void> remove(String id) async {
    final ref = _refuelRef;
    if (ref == null) return;
    await ref.child(id).remove();
    print("🗑️ Abastecimento $id removido!");
  }

  Future<List<Refuel>> show() async {
    final ref = _refuelRef;
    if (ref == null) return [];

    final snapshot = await ref.get();
    if (!snapshot.exists) return [];

    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return data.entries.map((entry) {
      final value = Map<String, dynamic>.from(entry.value);
      value['id'] = entry.key;
      return Refuel.fromMap(value);
    }).toList();
  }

  Stream<List<Refuel>> getRefuelStream() {
    final ref = _refuelRef;
    if (ref == null) return const Stream.empty();

    return ref.onValue.map((event) {
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
