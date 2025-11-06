import 'package:atividade_prova/ui/widgets/drawer.dart';
import 'package:atividade_prova/ui/widgets/header.dart';
import 'package:atividade_prova/viewmodels/refuel_viewmodel.dart';
import 'package:atividade_prova/viewmodels/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final refuelVM = context.watch<RefuelViewmodel>();
    final vehicleVM = VehicleViewmodel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasoline Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authVM.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: MeuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Header(),
            const SizedBox(height: 16),
            _buildSummaryCards(),
            const SizedBox(height: 16),
            _buildFuelList(context),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.directions_car,
                        color: Color.fromARGB(255, 166, 33, 243),
                      ),
                      title: const Text("Adicionar Veículo"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/newVehicle');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.local_gas_station,
                        color: Color.fromARGB(255, 130, 76, 175),
                      ),
                      title: const Text("Novo Abastecimento"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/novoAbastecimento');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSummaryCard(Icons.local_gas_station, "Abastecimentos", "5"),
        _buildSummaryCard(Icons.attach_money, "Total Gasto", "R\$ 496,58"),
        _buildSummaryCard(Icons.speed, "Média/L", "R\$ 5,89"),
      ],
    );
  }

  Widget _buildSummaryCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color.fromARGB(255, 71, 0, 202)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuelList(BuildContext context) {
    // aqui depois vamos trocar por um ListView.builder com dados reais
    final refuelVM = context.watch<RefuelViewmodel>();

    if (refuelVM.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final list = refuelVM.list;

    if (list.isEmpty) {
      return const Text("Nenhum abastecimento ainda.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Histórico de Abastecimentos",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...list.map(
          (a) => Card(
            child: ListTile(
              leading: const Icon(
                Icons.local_gas_station,
                color: Color.fromARGB(255, 71, 0, 202),
              ),
              title: Text(a.gasStation),
              subtitle: Text(a.date),
              trailing: Text(
                "R\$ ${a.value.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
