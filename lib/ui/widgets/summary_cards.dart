// ignore_for_file: deprecated_member_use

import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final refuelVM = context.watch<RefuelViewmodel>();
    final vehicleVM = context.watch<VehicleViewmodel>();
    final selectedVehicle = vehicleVM.selectedVehicle;

    final items = [
      {
        "icon": Icons.local_gas_station,
        "title": "Refuels",
        "value": refuelVM.getByVehicle(selectedVehicle?.id ?? "").length,
      },
      {
        "icon": Icons.attach_money,
        "title": "Total kilometers",
        "value": refuelVM.totalKm(selectedVehicle?.id).toStringAsFixed(1),
      },
      {
        "icon": Icons.speed,
        "title": "Km/L average",
        "value": refuelVM.avgKmPerLiter(selectedVehicle?.id).toStringAsFixed(1),
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),

        itemBuilder: (context, index) {
          final item = items[index];

          return Container(
            width: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(1, 3),
                ),
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item["icon"] as IconData, size: 28, color: colors.primary),
                const SizedBox(height: 10),
                Text(
                  item["title"] as String,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item["value"]}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
