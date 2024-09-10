import 'package:flutter/material.dart';
import '../widgets/user_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo blanco para el AppBar
        iconTheme: IconThemeData(color: Colors.brown[800]), // Íconos marrones
        elevation: 0, // Sin sombra en el AppBar
      ),
      drawer: UserDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con saludo mejorado y animado, ahora centrado
            _buildWelcomeSection(context),
            SizedBox(height: 20),
            // ¿Cómo va el día?
            Text(
              '¿Cómo va el día?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            // Tarjeta de Clima y Producción
            _buildInfoCard(),
            SizedBox(height: 20),
            // ¿Qué harás hoy?
            Text(
              '¿Qué harás hoy?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            // Sección de Mis Fincas con degradado
            _buildOptionCard(
              context,
              title: 'Mis fincas',
              description:
                  'Encuentra aquí la información detallada de tus fincas, puedes agregar, modificar y eliminar tus fincas.',
              buttonText: 'Ver fincas',
              onTap: () {
                Navigator.of(context).pushNamed('/misFincas');
              },
              gradientColors: [Colors.brown[800]!, Colors.brown[400]!], // Degradado para Mis Fincas
            ),
            SizedBox(height: 20),
            // Sección de Administrar con degradado
            _buildOptionCard(
              context,
              title: 'Administrar',
              description:
                  'Administra el personal de la finca, los pagos y recursos de la finca de manera eficiente.',
              buttonText: 'Administrar',
              onTap: () {
                Navigator.of(context).pushNamed('/administrar');
              },
              gradientColors: [Colors.green[800]!, Colors.green[400]!], // Degradado para Administrar
            ),
            SizedBox(height: 20),
            // ¿Necesitas ayuda?
            Text(
              '¿Necesitas ayuda?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            // Opciones de ayuda (Videos, Asesor IA)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHelpOption(
                  context,
                  icon: Icons.video_library,
                  label: 'Videos',
                  onTap: () {
                    // Acción al presionar "Videos"
                  },
                ),
                _buildHelpOption(
                  context,
                  icon: Icons.assistant,
                  label: 'Asesor IA',
                  onTap: () {
                    Navigator.of(context).pushNamed('/chatIA');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Sección de bienvenida centrada y con imagen del logo
  Widget _buildWelcomeSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth, // Hacemos que el contenedor ocupe el 100% del ancho disponible
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown[100]!, Colors.brown[300]!],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bienvenido a',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800],
            ),
          ),
          Text(
            'Coffee Manager',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800],
            ),
          ),
          SizedBox(height: 10),
          // Logo debajo del saludo
          Image.asset(
            'assets/images/logo2.png', // Logo colocado debajo del texto de bienvenida
            height: 90,
          ),
        ],
      ),
    );
  }

  // Tarjeta de Clima y Producción
  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown[100]!, Colors.brown[300]!],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoColumn(Icons.wb_sunny, 'Clima', 'Soleado - 22°C'),
          VerticalDivider(color: Colors.brown[800]),
          _buildInfoColumn(Icons.agriculture, 'Producción', '100 kg'),
        ],
      ),
    );
  }

  // Columna para los íconos de Clima y Producción
  Widget _buildInfoColumn(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.brown[800]),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }

  // Widget de tarjeta para cada opción con degradado
  Widget _buildOptionCard(BuildContext context,
      {required String title,
      required String description,
      required String buttonText,
      required Function onTap,
      required List<Color> gradientColors}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => onTap(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.brown[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para las opciones de ayuda
  Widget _buildHelpOption(BuildContext context,
      {required IconData icon,
      required String label,
      required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Icon(icon, color: Colors.brown[800], size: 40),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, color: Colors.brown[800])),
        ],
      ),
    );
  }
}
