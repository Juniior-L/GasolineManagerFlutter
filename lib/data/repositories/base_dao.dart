import 'package:firebase_database/firebase_database.dart';
import 'package:atividade_prova/data/services/auth_service.dart';

abstract class BaseDao {
  final _database = FirebaseDatabase.instance.ref();
  final _auth = AuthService();

  String? get userId {
    final id = _auth.getUserId();
    if (id == null || id.isEmpty) {
      // print("⚠️ Nenhum usuário autenticado!");
      return null;
    }
    return id;
  }

  DatabaseReference? get userRef {
    final id = userId;
    if (id == null) return null;
    return _database.child('users').child(id);
  }

  DatabaseReference? childRef(String path) {
    if (userId == null || userId!.isEmpty) {
      // print("⚠️ BaseDao: Usuário não autenticado, ignorando acesso a $path");
      return null;
    }
    return _database.child('users').child(userId!).child(path);
  }
}
