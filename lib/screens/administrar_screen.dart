import 'package:flutter/material.dart';

class AdministrarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.brown[800]), // Color del texto a blanco
        ),
        backgroundColor: Color.fromARGB(0, 109, 109, 109), // Fondo del AppBar
        iconTheme: IconThemeData(color: Colors.brown[800]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Descripción en la parte superior
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.menu_book, color: Color(0xFF5D7024), size: 28),
                SizedBox(width: 8),
                Text(
                  'Administrar',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'En esta sección encontrarás las funciones de agregar empleados, configurar el pago y los recursos de tus fincas',
              style: TextStyle(fontSize: 14, color: Colors.brown[700]),
            ),
            SizedBox(height: 16),
            // Tarjeta de Administrar Personal
            _buildAdminOption(
              context,
              icon: Icons.person_add_alt_1,
              label: 'Administrar Personal',
              color: Color(0xFF5D7024), // Color 5D7024B3
              route: '/personal', // Cambia por la ruta correspondiente
            ),
            SizedBox(height: 16),
            // Tarjeta de Administrar Pagos
            _buildAdminOption(
              context,
              icon: Icons.attach_money,
              label: 'Administrar Pagos',
              color: Color(0xFFA2C243), // Color A2C243D1
              route: '/pagos', // Cambia por la ruta correspondiente
            ),
            SizedBox(height: 16),
            // Tarjeta de Administrar Recursos
            _buildAdminOption(
              context,
              icon: Icons.build_circle,
              label: 'Administrar Recursos',
              color: Color(0xFF5D7024), // Color 5D7024B3
              route: '/recursos', // Cambia por la ruta correspondiente
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        width: double.infinity,
        height: 150, // Altura de la tarjeta ajustada
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 37,
              ),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(route);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
