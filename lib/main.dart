import 'package:atividade_prova/ui/pages/new_refuel_page.dart';
import 'package:atividade_prova/ui/pages/new_vehicle_page.dart';
import 'package:atividade_prova/ui/widgets/auth_wrapper.dart';
import 'package:atividade_prova/viewmodels/auth_viewmodel.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RefuelViewmodel()),
        ChangeNotifierProvider(create: (_) => VehicleViewmodel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gasoline Manager',
        theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
        home: const AuthWrapper(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/signup': (_) => const SignupPage(),
          '/home': (_) => const HomePage(),
          '/newVehicle': (_) => const NewVehiclePage(),
          '/newRefuel': (_) => const NewRefuelPage(),
          '/authWrapper': (_) => const AuthWrapper(),
        },
      ),
    );
  }
}
