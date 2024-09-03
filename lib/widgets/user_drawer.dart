import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: SafeArea(
        child: Container(
          height: screenHeight * 0.8, // 80% de la altura de la pantalla
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Información del usuario y Cerrar sesión
              UserAccountsDrawerHeader(
                accountName: Text(user?.displayName ?? 'Usuario'),
                accountEmail: Text(user?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      user?.photoURL ?? 'https://via.placeholder.com/150'),
                ),
                decoration: BoxDecoration(
                  color: Colors.brown[800],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildDrawerOption(
                      icon: Icons.show_chart,
                      label: 'Estadísticas',
                      onTap: () {
                        Navigator.of(context).pushNamed('/panel');
                      },
                    ),
                    _buildDrawerOption(
                      icon: Icons.admin_panel_settings,
                      label: 'Administración',
                      onTap: () {},
                    ),
                    _buildDrawerOption(
                      icon: Icons.park,
                      label: 'Mi finca',
                      onTap: () {},
                    ),
                    _buildDrawerOption(
                      icon: Icons.trending_up,
                      label: 'Datos del mercado',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.brown[800]),
                title: Text('Cerrar sesión',
                    style: TextStyle(color: Colors.brown[800])),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerOption({
    required IconData icon,
    required String label,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.brown[800]),
      title: Text(label, style: TextStyle(color: Colors.brown[800])),
      onTap: () => onTap(),
    );
  }
}
