// ignore_for_file: deprecated_member_use
import 'package:atividade_prova/l10n/app_localizations.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleCarousel extends StatelessWidget {
  const VehicleCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleVM = context.watch<VehicleViewmodel>();
    final refuelVM = context.watch<RefuelViewmodel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;
    String messageCarModel = " ";
    String messageCarPlate = " ";
    String messageCarExpensives = '';
    // ignore: prefer_typing_uninitialized_variables
    var v;

    if (vehicleVM.loading) {
      messageCarModel = t.loading;
      messageCarPlate = "";
    } else if (vehicleVM.list.isEmpty) {
      messageCarModel = t.noneVehicle;
      messageCarPlate = t.registerFirstVehicle;
    } else {
      v = vehicleVM.selectedVehicle!;
      messageCarModel = v.model;
      messageCarPlate = v.plate;
      messageCarExpensives = refuelVM.getTotalMonth(v.id).toStringAsFixed(1);
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colors.primary),
            onPressed: () => vehicleVM.previousVehicle(),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                messageCarModel,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                messageCarPlate,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.primary.withOpacity(0.7),
                ),
              ),
              Text(
                'R\$ $messageCarExpensives',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.primary.withOpacity(0.7),
                ),
              ),
            ],
          ),

          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: colors.primary),
            onPressed: () => vehicleVM.nextVehicle(),
          ),
        ],
      ),
    );
  }
}
