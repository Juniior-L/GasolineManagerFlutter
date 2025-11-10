import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.authStateChanges();

  // Login
  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Utilizador logado: ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Erro de login: ${e.message}');
    }
  }

  // Criar conta
  Future createUserWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('Utilizador criado: ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Erro ao criar: ${e.message}');
    }
  }

  // Logout
  Future signOut() async {
    await _auth.signOut();
    print('Utilizador deslogado.');
  }

  User? get currentUser => _auth.currentUser;

  String? getUserId() {
    return _auth.currentUser?.uid;
  }
}
