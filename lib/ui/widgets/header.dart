// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:atividade_prova/l10n/app_localizations.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final refuelVM = context.watch<RefuelViewmodel>();
    final vehicleVM = context.watch<VehicleViewmodel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    final v = vehicleVM.selectedVehicle;
    final now = DateTime.now();
    final monthName = _getMonthName(now.month);

    final totalMonth = v == null ? 0 : refuelVM.getTotalMonth(v.id!);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          // BACKGROUND IMAGE
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/fuel.jpg"), 
                fit: BoxFit.cover,
              ),
            ),
          ),

          // BLUR EFFECT
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              height: 180,
              width: double.infinity,
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          // GRADIENT OVERLAY
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month label
                Text(
                  t.monthOverview(monthName),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 6),

                // TITLE
                Text(
                  t.yourFuelBalance,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _stat(
                      context,
                      label: t.thisMonth,
                      value: "R\$ ${totalMonth.toStringAsFixed(2)}",
                      icon: Icons.attach_money,
                    ),
                    _stat(
                      context,
                      label: t.vehicle,
                      value: v?.model ?? t.selectOne,
                      icon: Icons.directions_car,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context,
      {required String label, required String value, required IconData icon}) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: colors.secondary, size: 30),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onPrimary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getMonthName(int m) {
    const months = [
      "", "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[m];
  }
}
