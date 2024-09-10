import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: TextStyle(color: Colors.brown[800])),
        backgroundColor: Colors.white, // Fondo blanco
        iconTheme:
            IconThemeData(color: Colors.brown[800]), // Iconos color café oscuro
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto de perfil con un estilo mejorado
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  user?.photoURL ?? 'https://via.placeholder.com/150',
                ),
                backgroundColor:
                    Colors.brown[100], // Fondo café claro para la foto
              ),
              SizedBox(height: 20),

              // Campos del perfil
              _buildProfileField(
                  'Nombre', user?.displayName ?? 'Nombre desconocido'),
              _buildProfileField('Apellido', 'Apellido por definir'),
              _buildProfileField('Celular', 'No disponible'),
              _buildProfileField('Correo', user?.email ?? 'No disponible'),
              _buildProfileField('Cédula', 'Sin definir'),

              // Botón para editar perfil
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Acción para editar el perfil
                },
                icon: Icon(Icons.edit, color: Color.fromARGB(255, 207, 182, 100)),
                label: Text('Editar Perfil'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255), // Fondo blanco
                  onPrimary: const Color.fromARGB(255, 0, 0, 0), // Texto morado
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)), // Borde morado
                  ),
                  elevation: 5, // Sombra ligera
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método auxiliar para construir los campos del perfil
  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.brown[800],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.brown[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Sombra suave
                ),
              ],
            ),
            width: double.infinity,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.brown[700]),
            ),
          ),
        ],
      ),
    );
  }
}
