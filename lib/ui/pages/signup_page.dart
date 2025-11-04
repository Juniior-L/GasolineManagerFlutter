import 'package:atividade_prova/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 20),
            authVM.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await authVM.register(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        if (user != null) {
                          // Se quiser logar e ir direto pra home:
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          Navigator.pop(context); // fallback
                        }
                      } on Exception catch (e) {
                        String msg = 'Erro ao criar conta';
                        if (e is FirebaseAuthException) msg = e.message ?? msg;
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(msg)));
                      }
                    },
                    child: const Text('Cadastrar'),
                  ),
          ],
        ),
      ),
    );
  }
}
