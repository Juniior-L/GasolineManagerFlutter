// ignore_for_file: deprecated_member_use

import 'package:atividade_prova/l10n/app_localizations.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../../viewmodels/auth_viewmodel.dart';
import '../../main.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final refuelVM = context.read<RefuelViewmodel>();
    final vehicleVM = context.read<VehicleViewmodel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: colors.surface,
      elevation: 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary, colors.primary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.onPrimary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.directions_car_rounded,
                    color: colors.onPrimary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GasTrack',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.welcomeMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onPrimary.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // MENU
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.directions_car_rounded,
                  text: t.myVehicles,
                  onTap: () => Navigator.pushNamed(context, '/vehicleList'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.local_gas_station_rounded,
                  text: t.registerRefuel,
                  onTap: () => Navigator.pushNamed(context, '/newRefuel'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.history_rounded,
                  text: t.refuelHistory,
                  onTap: () => Navigator.pushNamed(context, '/refuelList'),
                ),

                const SizedBox(height: 20),

                // 🔥 SELECTOR DE IDIOMA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    t.language,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),

                _buildDrawerItem(
                  context,
                  icon: Icons.language_rounded,
                  text: "English",
                  onTap: () => MyApp.setLocale(context, const Locale('en')),
                ),

                _buildDrawerItem(
                  context,
                  icon: Icons.language_rounded,
                  text: "Português",
                  onTap: () => MyApp.setLocale(context, const Locale('pt')),
                ),
              ],
            ),
          ),

          const Divider(indent: 16, endIndent: 16, height: 20),

          // LOGOUT
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(bottom: 20),
            child: ElevatedButton.icon(
              onPressed: () async {
                refuelVM.stopListening();
                vehicleVM.stopListening();
                await authVM.signOut(context);
              },
              icon: const Icon(Icons.logout_rounded),
              label: Text(t.logout),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ITEM
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      splashColor: colors.primary.withOpacity(0.15),
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.primary, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: colors.onSurface.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
