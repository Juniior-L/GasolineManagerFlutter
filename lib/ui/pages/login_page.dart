import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    final AuthService authService = AuthService();

    if (authVM.currentUser != null) {
      // Use pushReplacement para evitar voltar ao login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController),
            SizedBox(height: 20),
            authVM.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await authVM.signIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        // if (user != null) {
                        //   Navigator.pushReplacementNamed(context, '/home');
                        // }
                      } on Exception catch (e) {
                        String msg = 'Erro ao logar';
                        if (e is FirebaseAuthException) msg = e.message ?? msg;
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(msg)));
                      }
                    },
                    child: const Text('Entrar'),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
