import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'add_screen.dart';
import 'panel_screen.dart';
import 'misFincas_screen.dart';
import 'administrar_screen.dart';
import '../widgets/user_drawer.dart';

class MainScreen extends StatefulWidget {
  static final GlobalKey<_MainScreenState> mainScreenKey =
      GlobalKey<_MainScreenState>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // Por defecto, el índice de "Inicio"

  final List<Widget> _screens = [
    PanelScreen(),
    HomeScreen(),
    AddScreen(),
    MisFincas(),
    AdministrarScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Ocultar la barra de navegación del sistema y la barra de estado
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainScreen.mainScreenKey, // Asignamos la key aquí
      drawer: UserDrawer(), // Drawer para el menú lateral
      body: _screens[_selectedIndex], // Pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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
