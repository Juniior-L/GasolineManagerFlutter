import 'package:flutter/material.dart';

class MeuDrawer extends Drawer {
  const MeuDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: const Color.fromARGB(255, 71, 0, 202)),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              if (context.widget.toString() == 'PrimeiraTela') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/primeira');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury),
            title: Text('Segunda Tela'),
            onTap: () {
              Navigator.pushNamed(context, '/segunda');
            },
          ),
        ],
      ),
    );
  }
}