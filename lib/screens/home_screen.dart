import 'package:flutter/material.dart';
import '../widgets/user_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.brown[800]),
        ),
        backgroundColor: Color.fromARGB(0, 109, 109, 109),
        iconTheme: IconThemeData(color: Colors.brown[800]),
      ),
      drawer: UserDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido a',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    Text(
                      'Coffee Manager',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://i.imgur.com/cTALbZL.png'), // Imagen de café desde la web
                ),
              ],
            ),
            SizedBox(height: 20),
            // ¿Cómo va el día?
            Text(
              '¿Cómo va el día?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.wb_sunny, color: Colors.brown[800]),
                          SizedBox(width: 5),
                          Text(
                            'Clima',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('Soleado - 22°C',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                  VerticalDivider(color: Colors.brown[800]),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.agriculture, color: Colors.brown[800]),
                          SizedBox(width: 5),
                          Text(
                            'Producción',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('100 kg',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // ¿Qué harás hoy?
            Text(
              '¿Qué harás hoy?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            // Mis Fincas
            Container(
              decoration: BoxDecoration(
                color: Colors.brown[800], // Fondo color café
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.2),
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
                      'Mis fincas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Texto blanco
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Encuentra aquí la información detallada de tus fincas, puedes agregar, modificar y eliminar tus fincas.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70, // Texto blanco suave
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/misFincas');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Fondo blanco
                          onPrimary: Colors.brown[800], // Texto marrón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Fincas'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Administrar
            Container(
              decoration: BoxDecoration(
                color: Colors.brown[800], // Fondo color café
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
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
                      'Administrar',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white), // Texto blanco
                    ),
                    SizedBox(height: 8),
                    Text(
                      'En esta sección puedes agregar el personal de la finca, administrar los pagos y recursos de la finca.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70, // Texto blanco suave
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/administrar');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Fondo blanco
                          onPrimary: Colors.brown[800], // Texto marrón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Administrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // ¿Necesitas ayuda?
            Text(
              '¿Necesitas ayuda?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
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
