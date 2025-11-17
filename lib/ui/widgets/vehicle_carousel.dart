// ignore_for_file: deprecated_member_use

import 'package:atividade_prova/core/themes/theme.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleCarousel extends StatelessWidget {
  const VehicleCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleVM = context.watch<VehicleViewmodel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (vehicleVM.loading || vehicleVM.list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          "None vehicle yet",
          style: theme.textTheme.titleMedium,
        ),
      );
    }

    final v = vehicleVM.selectedVehicle!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            
            AppTheme.primaryColor.withOpacity(0.85),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colors.onPrimary),
            onPressed: () => vehicleVM.previousVehicle(),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                v.model,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                v.plate,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),

          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: colors.onPrimary),
            onPressed: () => vehicleVM.nextVehicle(),
          ),
        ],
      ),
    );
  }
}

// HEADER 
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,

            AppTheme.primaryColor.withOpacity(0.85),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "November",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onPrimary.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Expensives",
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "R\$ 496,58",
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }