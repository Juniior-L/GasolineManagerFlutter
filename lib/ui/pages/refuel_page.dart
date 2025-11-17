import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class RefuelListPage extends StatelessWidget {
  const RefuelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final refuelVm = Provider.of<RefuelViewmodel>(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('My Refuels')),

      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              'Track your fuel history easily ⛽',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),

          // LIST
          Expanded(
            child: refuelVm.list.isEmpty
                ? Center(
                    child: Text(
                      'No refuels yet ⛽',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    itemCount: refuelVm.list.length,
                    itemBuilder: (context, index) {
                      final refuel = refuelVm.list[index];
                      return _buildRefuelCard(context, refuel);
                    },
                  ),
          ),
        ],
      ),

      // BUTTON — usa cores do tema automaticamente
      floatingActionButton: SpeedDial(
        icon: Icons.add_rounded,
        activeIcon: Icons.close_rounded,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        spacing: 6,
        spaceBetweenChildren: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.local_gas_station_rounded),
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

  // CARD
  Widget _buildRefuelCard(BuildContext context, Refuel refuel) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final vehicleVM = context.watch<VehicleViewmodel>();
    final v = vehicleVM.vehicleModel(refuel.vehicleId!);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.local_gas_station_rounded,
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "R\$ ${refuel.value.toStringAsFixed(2)}",
                          style: theme.textTheme.titleLarge,
                        ),
                        Text(refuel.date, style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),

                // MENU
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert_rounded, color: colors.onSurface),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.pushNamed(context, '/EditRefuel');
                    } else if (value == 'delete') {
                      Provider.of<RefuelViewmodel>(
                        context,
                        listen: false,
                      ).remove(refuel.id!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Refuel removed successfully!"),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_rounded, color: colors.primary),
                          const SizedBox(width: 8),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_rounded, color: colors.error),
                          const SizedBox(width: 8),
                          const Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            // INFOS
            _buildInfoRow(context, 'Gas station', refuel.gasStation),
            _buildInfoRow(context, 'Liters', refuel.liters.toStringAsFixed(2)),
            _buildInfoRow(context, 'Odometer', '${refuel.kilometers} km'),
            _buildInfoRow(
              context,
              'Vehicle',
              v == null ? 'Vehicle removed' : '${v.model} • ${v.plate}',
            ),

            if (refuel.note.isNotEmpty) ...[
              const SizedBox(height: 6),
              _buildInfoRow(
                context,
                'Note',
                refuel.note,
                highlight: true,
                icon: Icons.sticky_note_2_outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }

  //INFO ROW
  Widget _buildInfoRow(
    BuildContext context,
    String title,
    String value, {
    bool highlight = false,
    IconData? icon,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(icon, color: colors.primary, size: 18),
                ),
              Text(title, style: theme.textTheme.bodyMedium),
            ],
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
                color: highlight ? colors.primary : colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
