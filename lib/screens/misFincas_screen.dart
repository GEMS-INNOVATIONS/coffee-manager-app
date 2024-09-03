import 'package:flutter/material.dart';

class MisFincas extends StatefulWidget {
  @override
  _MisFincasScreenState createState() => _MisFincasScreenState();
}

class _MisFincasScreenState extends State<MisFincas> {
  bool _showHelpMessage = true;

  @override
  void initState() {
    super.initState();

    // Mostrar el mensaje emergente al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSnackBar();
    });
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '📋 En esta pantalla podrás crear o modificar los datos de tu finca. Este es el primer paso para empezar a trabajar con Coffee Manager.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis fincas', style: TextStyle(color: Colors.brown[800])),
        backgroundColor: Color.fromARGB(0, 109, 109, 109),
        iconTheme: IconThemeData(color: Colors.brown[800]),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _showSnackBar, // Reutilizamos el mismo SnackBar
          ),
        ],
      ),
     
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFincaCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFincaCard() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://via.placeholder.com/100', // Imagen de muestra
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MI FINCA (🌿 EDITAME)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Administrador: SIN DEFINIR'),
                  Text('Ubicación: SIN DEFINIR'),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Acción al presionar el botón Editar
              },
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text('Editar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green[800],
                onPrimary: Colors.white, // Asegura que el texto sea blanco
              ),
            ),
          ],
        ),
      ),
    );
  }
}
