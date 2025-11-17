// ignore_for_file: use_build_context_synchronously

import 'package:atividade_prova/core/themes/theme.dart';
import 'package:atividade_prova/utils/parse_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';

class NewRefuelPage extends StatefulWidget {
  const NewRefuelPage({super.key});

  @override
  State<NewRefuelPage> createState() => _NewRefuelPageState();
}

class _NewRefuelPageState extends State<NewRefuelPage> {
  final kilometersController = TextEditingController();
  final gasStationController = TextEditingController();
  final valueController = TextEditingController();
  final litersController = TextEditingController();
  final dateController = TextEditingController();
  final noteController = TextEditingController();

  String? selectedVehicleId;

  final NumberFormat numberFormat = NumberFormat.decimalPattern('pt_BR');
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  void dispose() {
    kilometersController.dispose();
    gasStationController.dispose();
    valueController.dispose();
    litersController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleVM = context.watch<VehicleViewmodel>();
    final refuelVM = context.read<RefuelViewmodel>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("New Refuel"),
        elevation: theme.appBarTheme.elevation,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Register Refuel",
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Fill the refuel information carefully.",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // Vehicle Dropdown
            vehicleVM.loading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Vehicle",
                        prefixIcon: const Icon(Icons.directions_car_outlined),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedVehicleId,
                          hint: Text(
                            "Select the vehicle",
                            style: theme.inputDecorationTheme.hintStyle,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(14),
                          items: vehicleVM.list
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v.id,
                                  child: Text(
                                    '${v.model} (${v.plate})',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedVehicleId = value),
                        ),
                      ),
                    ),
                  ),

            // Fields
            _buildField(
              label: "Current Km",
              controller: kilometersController,
              icon: Icons.speed_outlined,
              type: TextInputType.number,
              theme: theme,
            ),
            _buildField(
              label: "Gas Station",
              controller: gasStationController,
              icon: Icons.local_gas_station_outlined,
              theme: theme,
            ),
            _buildField(
              label: "Total Value (R\$)",
              controller: valueController,
              icon: Icons.attach_money_outlined,
              type: const TextInputType.numberWithOptions(decimal: true),
              theme: theme,
            ),
            _buildField(
              label: "Liters",
              controller: litersController,
              icon: Icons.water_drop_outlined,
              type: const TextInputType.numberWithOptions(decimal: true),
              theme: theme,
            ),
            _buildDateField(context, theme),
            _buildField(
              label: "Notes",
              controller: noteController,
              icon: Icons.note_outlined,
              theme: theme,
            ),

            const SizedBox(height: 40),

            //Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline, size: 22),
                label: const Text("Save refuel"),
                onPressed: () async {
                  if (selectedVehicleId == null ||
                      kilometersController.text.trim().isEmpty ||
                      gasStationController.text.trim().isEmpty ||
                      valueController.text.trim().isEmpty ||
                      litersController.text.trim().isEmpty ||
                      dateController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Please fill all required fields!"),
                        backgroundColor: theme.colorScheme.error,
                      ),
                    );
                    return;
                  }
                  await refuelVM.save(
                    selectedVehicleId!,
                    parseNumber(kilometersController.text),
                    gasStationController.text.trim(),
                    parseNumber(valueController.text),
                    parseNumber(litersController.text),
                    dateController.text.trim(),
                    noteController.text.trim(),
                  );
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Refuel saved successfully!"),
                      backgroundColor: theme.colorScheme.primary,
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

  //Reusable Text Field
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required ThemeData theme,
    TextInputType type = TextInputType.text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          hintText: "Type the $label",
        ),
      ),
    );
  }

  //Date Picker Field
  Widget _buildDateField(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: TextField(
        controller: dateController,
        readOnly: true,
        style: theme.textTheme.bodyLarge,
        decoration: const InputDecoration(
          labelText: "Date",
          prefixIcon: Icon(Icons.calendar_today_outlined),
          hintText: "Select the date",
        ),
        onTap: () async {
          FocusScope.of(context).unfocus();
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: theme.copyWith(
                  colorScheme: theme.colorScheme.copyWith(
                    primary: AppTheme.primaryColor,
                  ),
                ),
                child: child ?? const SizedBox(),
              );
            },
          );
          if (pickedDate != null) {
            dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          }
        },
      ),
    );
  }
}
