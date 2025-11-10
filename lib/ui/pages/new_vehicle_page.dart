import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';

class NewVehiclePage extends StatefulWidget {
  const NewVehiclePage({super.key});

  @override
  State<StatefulWidget> createState() => _NewVehicleState();
}

class _NewVehicleState extends State<NewVehiclePage> {
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final yearController = TextEditingController();
  final fuelTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vehicleVM = VehicleViewmodel();

    // if (authVM.currentUser != null) {
    //   // Use pushReplacement para evitar voltar ao login
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacementNamed(context, '/home');
    //   });
    // }

    return Scaffold(
      appBar: AppBar(title: Text("Cadastro Veículo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: modelController,
              decoration: const InputDecoration(labelText: "Modelo"),
            ),
            TextFormField(
              controller: plateController,
              decoration: const InputDecoration(labelText: "Placa"),
            ),
            TextFormField(
              controller: yearController,
              decoration: const InputDecoration(labelText: "Ano"),
            ),
            TextFormField(
              controller: fuelTypeController,
              decoration: const InputDecoration(labelText: "Combustível"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                vehicleVM.save(
                  modelController.text,
                  plateController.text,
                  yearController.text,
                  fuelTypeController.text,
                );
              },
              child: Text("Criar"),
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
