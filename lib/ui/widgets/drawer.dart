import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class MeuDrawer extends Drawer {
  const MeuDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 71, 0, 202),
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Meus Veiculos'),
            onTap: () {
              if (context.widget.toString() == 'Meus Veiculos') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/vehicleList');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury),
            title: Text('Registrar Abastecimento'),
            onTap: () {
              Navigator.pushNamed(context, '/newRefuel');
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury),
            title: Text('Histórico de Abastecimento'),
            onTap: () {
              Navigator.pushNamed(context, '/refuelList');
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury),
            title: Text('Sair'),
            onTap: () async {
              await authVM.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
