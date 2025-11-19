// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:atividade_prova/l10n/app_localizations.dart';
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
  void dispose() {
    modelController.dispose();
    plateController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleVM = context.read<VehicleViewmodel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.addVehicle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              t.addVehicle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              t.fillCarefull,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // INPUTS
            _modernInput(
              label: t.model,
              controller: modelController,
              theme: theme,
              icon: Icons.directions_car_rounded,
            ),

            _modernInput(
              label: t.licensePlate,
              controller: plateController,
              theme: theme,
              icon: Icons.credit_card_rounded,
              textCapitalization: TextCapitalization.characters,
            ),

            _modernInput(
              label: t.year,
              controller: yearController,
              theme: theme,
              icon: Icons.calendar_month_rounded,
              keyboardType: TextInputType.number,
            ),

            _fuelDropdown(theme),

            const SizedBox(height: 40),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: Text(t.save),
                onPressed: () async {
                  if (selectedFuelType == null ||
                      modelController.text.trim().isEmpty ||
                      plateController.text.trim().isEmpty ||
                      yearController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.fillFields),
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

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.vehicleSaved),
                    ),
                  );

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // INPUT FIELD

  Widget _modernInput({
    required String label,
    required TextEditingController controller,
    required ThemeData theme,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: _glassContainer(
        theme,
        child: Row(
          children: [
            Icon(icon, size: 22, color: theme.colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                textCapitalization: textCapitalization,
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DROPDOWN FIELD

  Widget _fuelDropdown(ThemeData theme) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: _glassContainer(
        theme,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedFuelType,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            hint: Text(t.fuelType, style: theme.textTheme.bodyMedium),
            items: fuelTypes
                .map((fuel) => DropdownMenuItem(value: fuel, child: Text(fuel)))
                .toList(),
            onChanged: (value) => setState(() => selectedFuelType = value),
          ),
        ),
      ),
    );
  }

  // GLASS CONTAINER

  Widget _glassContainer(ThemeData theme, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
