import 'package:atividade_prova/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// Import das páginas
import 'ui/pages/login_page.dart';
import 'ui/pages/signup_page.dart';
import 'ui/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gasoline Manager',
        theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginPage(),
          '/signup': (_) => const SignupPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
