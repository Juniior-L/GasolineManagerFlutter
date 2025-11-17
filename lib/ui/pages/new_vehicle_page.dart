import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';

class NewVehiclePage extends StatefulWidget {
  const NewVehiclePage({super.key});

  @override
  State<NewVehiclePage> createState() => _NewVehiclePageState();
}

class _NewVehiclePageState extends State<NewVehiclePage> {
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final yearController = TextEditingController();

  String? selectedFuelType;

  final List<String> fuelTypes = const [
    "Diesel",
    "Diesel-S10",
    "Etanol",
    "Podium",
    "Gasolina",
    "Aditivada",
    "Querosene",
  ];

  @override
  Widget build(BuildContext context) {
    final vehicleVM = context.watch<VehicleViewmodel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("New Vehicle")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              "Register Vehicle",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Text(
              "Fill the information carefully.",
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 30),

            // INPUTS
            _formField(
              label: "Model",
              controller: modelController,
              icon: Icons.directions_car_outlined,
            ),

            _formField(
              label: "Licence Plate",
              controller: plateController,
              icon: Icons.credit_card_outlined,
              textCapitalization: TextCapitalization.characters,
            ),

            _formField(
              label: "Year",
              controller: yearController,
              type: TextInputType.number,
              icon: Icons.calendar_today_outlined,
            ),

            // Fuel dropdown
            _fuelDropdown(),

            const SizedBox(height: 40),

            // BOTÃO usando tema
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Save vehicle"),
                onPressed: () async {
                  if (selectedFuelType == null ||
                      modelController.text.trim().isEmpty ||
                      plateController.text.trim().isEmpty ||
                      yearController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Fill all the fields!"),
                        backgroundColor: theme.colorScheme.error,
                      ),
                    );
                    return;
                  }

                  await vehicleVM.save(
                    modelController.text.trim(),
                    plateController.text.trim(),
                    yearController.text.trim(),
                    selectedFuelType!,
                  );

                  if (!mounted) return;

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Vehicle added successfully!"),
                    ),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== INPUT FIELD PADRONIZADO PELO TEMA =====
  Widget _formField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    TextInputType type = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: type,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  // ===== DROPDOWN COM O TEMA =====
  Widget _fuelDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        initialValue: selectedFuelType,
        decoration: const InputDecoration(
          labelText: "Fuel Type",
          prefixIcon: Icon(Icons.local_gas_station_outlined),
        ),
        items: fuelTypes
            .map(
              (fuel) => DropdownMenuItem(
                value: fuel,
                child: Text(fuel),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => selectedFuelType = value),
      ),
    );
  }
}
