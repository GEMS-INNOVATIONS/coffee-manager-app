import 'package:flutter/material.dart';

class AdministrarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.brown[800]), // Color del texto marrón
        ),
        backgroundColor: Colors.white, // Fondo blanco del AppBar
        iconTheme: IconThemeData(color: Colors.brown[800]), // Íconos marrones
        elevation: 0, // Sin sombra
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la página
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
                    color: Colors.brown[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Descripción de la página
            Text(
              'En esta sección encontrarás las funciones de agregar empleados, configurar el pago y los recursos de tus fincas.',
              style: TextStyle(fontSize: 14, color: Colors.brown[700]),
            ),
            SizedBox(height: 16),
            // Tarjeta de Administrar Personal con degradado
            _buildAdminOption(
              context,
              icon: Icons.person_add_alt_1,
              label: 'Administrar Personal',
              gradientColors: [Colors.brown[800]!, Colors.brown[400]!],
              route: '/personal', // Cambia por la ruta correspondiente
            ),
            SizedBox(height: 16),
            // Tarjeta de Administrar Pagos con degradado
            _buildAdminOption(
              context,
              icon: Icons.attach_money,
              label: 'Administrar Pagos',
              gradientColors: [Colors.green[800]!, Colors.green[400]!],
              route: '/pagos', // Cambia por la ruta correspondiente
            ),
            SizedBox(height: 16),
            // Tarjeta de Administrar Recursos con degradado
            _buildAdminOption(
              context,
              icon: Icons.build_circle,
              label: 'Administrar Recursos',
              gradientColors: [Colors.brown[800]!, Colors.brown[400]!],
              route: '/recursos', // Cambia por la ruta correspondiente
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir cada opción de administración con degradado
  Widget _buildAdminOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required List<Color> gradientColors,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        width: double.infinity,
        height: 150, // Altura ajustada para las tarjetas
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors), // Degradado aplicado
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.3),
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
                  onPrimary: gradientColors.last,
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
