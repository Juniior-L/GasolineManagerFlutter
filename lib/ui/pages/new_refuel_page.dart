// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:atividade_prova/l10n/app_localizations.dart';
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
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;


    return Scaffold(
      appBar: AppBar(title: Text(t.addRefuel)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              t.registerRefuel,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(t.fillCarefull, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 28),

            // VEHICLE DROPDOWN
            _glassContainer(
              theme,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedVehicleId,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  hint: Text(
                    t.selectVehicle,
                    style: theme.textTheme.bodyMedium,
                  ),
                  items: vehicleVM.list
                      .map(
                        (v) => DropdownMenuItem(
                          value: v.id,
                          child: Text("${v.model} (${v.plate})"),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedVehicleId = value),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // INPUTS
            _modernInput(
              label: t.odometer,
              controller: kilometersController,
              theme: theme,
              icon: Icons.speed_rounded,
              keyboardType: TextInputType.number,
            ),
            _modernInput(
              label: t.gasStation,
              controller: gasStationController,
              theme: theme,
              icon: Icons.local_gas_station,
            ),
            _modernInput(
              label: "Total Value (R\$)",
              controller: valueController,
              theme: theme,
              keyboardType: TextInputType.number,
              icon: Icons.attach_money_rounded,
            ),
            _modernInput(
              label: t.liters,
              controller: litersController,
              theme: theme,
              keyboardType: TextInputType.number,
              icon: Icons.water_drop_rounded,
            ),
            _dateInput(theme, context),
            _modernInput(
              label: t.notes,
              controller: noteController,
              theme: theme,
              icon: Icons.note_alt_outlined,
            ),

            const SizedBox(height: 28),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(t.save),
                onPressed: () async {
                  if (selectedVehicleId == null ||
                      kilometersController.text.isEmpty ||
                      gasStationController.text.isEmpty ||
                      valueController.text.isEmpty ||
                      litersController.text.isEmpty ||
                      dateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.fillFields)),
                    );
                    return;
                  }

                  await refuelVM.save(
                    selectedVehicleId!,
                    parseNumber(kilometersController.text),
                    gasStationController.text,
                    parseNumber(valueController.text),
                    parseNumber(litersController.text),
                    dateController.text,
                    noteController.text,
                  );

                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MODERN INPUT CONTAINER
  Widget _modernInput({
    required String label,
    required TextEditingController controller,
    required ThemeData theme,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _glassContainer(
        theme,
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
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

  // DATE INPUT
  Widget _dateInput(ThemeData theme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _glassContainer(
        theme,
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),

            Expanded(
              child: TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Date",
                  border: InputBorder.none,
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );

                  if (date != null) {
                    dateController.text = DateFormat("dd/MM/yyyy").format(date);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // EFFECT CONTAINER (modern glass-like)
  Widget _glassContainer(ThemeData theme, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.9),
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
