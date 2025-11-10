import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/vehicle_viewmodel.dart';
import '../../data/models/vehicle_model.dart';

class VehicleListPage extends StatelessWidget {
  const VehicleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleViewModel = Provider.of<VehicleViewmodel>(context);
    final theme = Theme.of(context); 
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Veículos'), centerTitle: true),
      body: Column(
        children: [
          Container(
            color: colors.primary,
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Text(
              'Coloca qualquer coisa aqui',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: vehicleViewModel.list.isEmpty
                ? Center(
                    child: Text(
                      'Nenhum veículo registrado ainda',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        // ignore: deprecated_member_use
                        color: colors.onSurface.withOpacity(0.6),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: vehicleViewModel.list.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final vehicle = vehicleViewModel.list[index];
                      return _buildVehicleCard(context, vehicle);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: colors.secondary,
        foregroundColor: colors.onSecondary,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.directions_car),
            label: 'Adicionar Veículo',
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            onTap: () => Navigator.pushNamed(context, '/newVehicle'),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context, Vehicle vehicle) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_car, color: colors.primary),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vehicle.model, style: theme.textTheme.titleLarge),
                        Text(
                          vehicle.model,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            // ignore: deprecated_member_use
                            color: colors.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: colors.onSurface),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Informações
            _buildInfoRow(context, 'License plate', vehicle.plate),
            _buildInfoRow(context, 'Fuel type', vehicle.fueltype),

            const Divider(height: 24),

            // Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current status',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Active',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.greenAccent[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String title, String value) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              // ignore: deprecated_member_use
              color: colors.onSurface.withOpacity(0.6),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
