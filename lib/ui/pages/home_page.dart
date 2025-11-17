// ignore_for_file: deprecated_member_use
import 'package:atividade_prova/ui/widgets/chart.dart';
import 'package:atividade_prova/ui/widgets/drawer.dart';
import 'package:atividade_prova/ui/widgets/refuel_history.dart';
import 'package:atividade_prova/ui/widgets/summary_cards.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:atividade_prova/ui/widgets/vehicle_carousel.dart';
import '../../viewmodels/auth_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final refuelVM = context.watch<RefuelViewmodel>();
    final vehicleVM = context.watch<VehicleViewmodel>();

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final selectedVehicle = vehicleVM.selectedVehicle;

    final List<FlSpot> spots = selectedVehicle == null
        ? []
        : refuelVM.getSpots(selectedVehicle.id!);

    final List<Map<String, String>> refuelList = selectedVehicle == null
        ? []
        : refuelVM.getHistoryFormatted(selectedVehicle.id!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("GasTrack"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: colors.onPrimary),
            onPressed: () async => await authVM.signOut(context),
          ),
        ],
      ),

      drawer: MeuDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummaryCards(),
            const SizedBox(height: 24),
            VehicleCarousel(),
            RefuelChart(spots: spots),
            const SizedBox(height: 32),
            FuelHistory(history: refuelList),
          ],
        ),
      ),

      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        overlayColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        spacing: 8,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.directions_car),
            label: 'Add vehicle',
            backgroundColor: colors.secondary,
            foregroundColor: colors.onSecondary,
            labelStyle: theme.textTheme.bodyMedium,
            onTap: () => Navigator.pushNamed(context, '/newVehicle'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.local_gas_station),
            label: 'Add refuel',
            backgroundColor: colors.secondary,
            foregroundColor: colors.onSecondary,
            labelStyle: theme.textTheme.bodyMedium,
            onTap: () => Navigator.pushNamed(context, '/newRefuel'),
          ),
        ],
      ),
    );
  }
}
