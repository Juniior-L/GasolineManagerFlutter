import 'package:atividade_prova/data/models/refuel_model.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class RefuelListPage extends StatelessWidget {
  const RefuelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final refuelViewModel = Provider.of<RefuelViewmodel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF068BF8),
        title: const Text('Abastecimentos'),
        centerTitle: true,
        elevation: 0,
        // actions: [
        //   IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        //   IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        // ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Text(
              'Coloca qualquer coisa aqui',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: refuelViewModel.list.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum Abastecimento registrado ainda',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: refuelViewModel.list.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final refuel = refuelViewModel.list[index];
                      return _buildRefuelCard(context, refuel);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: const Color.from(
          alpha: 1,
          red: 0.278,
          green: 0,
          blue: 0.792,
        ),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.local_gas_station),
            label: 'Adicionar abastecimento',
            onTap: () => Navigator.pushNamed(context, '/newRefuel'),
          ),
        ],
      ),
    );
  }

  Widget _buildRefuelCard(BuildContext context, Refuel refuel) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
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
                    const Icon(Icons.local_gas_station_sharp , color: Colors.grey),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'R\$ ${refuel.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          refuel.date,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),

            const SizedBox(height: 12),

            // Informações
            _buildInfoRow('Posto', refuel.gasStation),
            _buildInfoRow('Litros', refuel.liters.toStringAsFixed(2)),
            _buildInfoRow('Quilometros', refuel.kilometers.toStringAsFixed(2)),

            // _buildInfoRow(
            //   'Last refuel',
            //   'R\$ ${refuel.lastRefuelValue?.toStringAsFixed(2) ?? '0.00'}',
            // ),
            const Divider(height: 24),

            // Saldo atual / botão editar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Observação',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  refuel.note,
                  style: const TextStyle(
                    color: Colors.green,
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

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
