import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'add_screen.dart';
import 'panel_screen.dart';
import 'misFincas_screen.dart';
import 'administrar_screen.dart';
import 'fincaDetail_screen.dart';
import 'administrarPago_screen.dart';
import 'perfil_screen.dart';
import '../widgets/user_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // El índice por defecto es 1 para "Inicio"

  // Lista de pantallas que se mostrarán en el cuerpo
  final List<Widget> _screens = [
    PanelScreen(), // Pantalla de Panel
    HomeScreen(), // Pantalla de Inicio
    AddScreen(), // Pantalla de Agregar
    MisFincas(), // Pantalla de Mis Fincas
    FincaDetail(), // Pantalla de Detalle de Finca
    PerfilScreen(), // Pantalla de Perfil
    AdministrarScreen(), // Pantalla de Administración
    AdministrarPagos(),
  ];

  @override
  void initState() {
    super.initState();
    // Ocultar la barra de navegación del sistema y la barra de estado
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  // Método para cambiar de vista cuando se toca el ítem del menú
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia la pantalla en función del índice
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawer(), // Menú lateral
      body: _screens[
          _selectedIndex], // Pantalla que se muestra según el índice seleccionado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Muestra el ítem seleccionado
        selectedItemColor: Colors.brown[800], // Color del ítem seleccionado
        unselectedItemColor: Colors.grey, // Color de los ítems no seleccionados
        onTap: _onItemTapped, // Cambiar pantalla al tocar un ítem
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Agregar',
          ),
        ],
      ),
    );
  }
}
