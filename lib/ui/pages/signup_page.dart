// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../core/themes/theme.dart';
import '../../viewmodels/auth_viewmodel.dart';

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
    final authVM = Provider.of<AuthViewModel>(context);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppTheme.shadowColor.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_add_alt_1_rounded,
                      color: colors.primary,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Create Account",
                    style: textTheme.titleLarge?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Fill in your details to register",
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 28),
                  authVM.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              final user = await authVM.register(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              if (user != null) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            } on Exception catch (e) {
                              String msg = 'Error on Creating account';
                              if (e is FirebaseAuthException) {
                                if (e.code == 'email-already-in-use') {
                                  msg =
                                      'This email is already in use. Try logging in.';
                                } else if (e.code == 'invalid-email') {
                                  msg = 'Invalid email format.';
                                } else if (e.code == 'weak-password') {
                                  msg =
                                      'Password must be at least 6 characters.';
                                } else {
                                  msg = 'Fill the fields.';
                                }
                              }

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(msg)));
                            }
                          },
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text("Sign Up"),
                        ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back to Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
