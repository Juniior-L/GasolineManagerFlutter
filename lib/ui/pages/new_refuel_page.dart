import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';

class NewRefuelPage extends StatefulWidget {
  const NewRefuelPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewRefuelState();
}

class _NewRefuelState extends State<NewRefuelPage> {
  final kilometersController = TextEditingController();
  final gasStationController = TextEditingController();
  final valueController = TextEditingController();
  final litersController = TextEditingController();
  final dateController = TextEditingController();
  final noteController = TextEditingController();

  String? selectedVehicleId;

  @override
  Widget build(BuildContext context) {
    final vehicleVM = Provider.of<VehicleViewmodel>(context);
    final refuelVM = Provider.of<RefuelViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Abastecimento")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔥 Dropdown com os veículos do VehicleViewmodel
              vehicleVM.loading
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButton<String>(
                      isExpanded: true,
                      value: selectedVehicleId,
                      hint: const Text('Selecione o veículo'),
                      items: vehicleVM.list.map((v) {
                        return DropdownMenuItem(
                          value: v.id,
                          child: Text('${v.model} (${v.plate})'),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedVehicleId = value),
                    ),

              const SizedBox(height: 20),
              TextFormField(
                controller: kilometersController,
                decoration: const InputDecoration(labelText: "Km atual"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: gasStationController,
                decoration: const InputDecoration(labelText: "Posto"),
              ),
              TextFormField(
                controller: valueController,
                decoration: const InputDecoration(labelText: "Valor total"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: litersController,
                decoration: const InputDecoration(labelText: "Litros"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Data (dd/mm/aaaa)",
                ),
              ),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(labelText: "Observação"),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (selectedVehicleId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Selecione um veículo")),
                    );
                    return;
                  }

                  await refuelVM.save(
                    selectedVehicleId!,
                    toDouble(kilometersController.text),
                    gasStationController.text,
                    toDouble(valueController.text),
                    toDouble(litersController.text),
                    dateController.text,
                    noteController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Abastecimento salvo!")),
                  );

                  kilometersController.clear();
                  gasStationController.clear();
                  valueController.clear();
                  litersController.clear();
                  dateController.clear();
                  noteController.clear();
                  setState(() => selectedVehicleId = null);
                },
                child: const Text("Salvar Abastecimento"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double toDouble(String value) {
    if (value.isEmpty) return 0.0;
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }
}
