import 'package:firebase_database/firebase_database.dart';
import 'package:atividade_prova/data/services/auth_service.dart';

abstract class BaseDao {
  final _database = FirebaseDatabase.instance.ref();
  final _auth = AuthService();

  /// Retorna o ID do usuário autenticado, ou `null` se não houver.
  String? get userId {
    final id = _auth.getUserId();
    if (id == null || id.isEmpty) {
      print("⚠️ Nenhum usuário autenticado!");
      return null;
    }
    return id;
  }

  /// Retorna o nó principal do usuário logado.
  DatabaseReference? get userRef {
    final id = userId;
    if (id == null) return null;
    return _database.child('users').child(id);
  }

  /// Retorna o nó específico de um tipo de dado, ex: 'refuels', 'vehicles' etc.
  // DatabaseReference? childRef(String childPath) {
  //   final ref = userRef;
  //   if (ref == null) return null;
  //   return ref.child(childPath);
  // }

  DatabaseReference? childRef(String path) {
    if (userId == null || userId!.isEmpty) {
      print("⚠️ BaseDao: Usuário não autenticado, ignorando acesso a $path");
      return null;
    }
    return _database.child('users').child(userId!).child(path);
  }
}
