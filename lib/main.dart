import 'package:coffeemanager/screens/administrar_screen.dart';
import 'package:coffeemanager/screens/chat_ia_screen.dart';
import 'package:coffeemanager/screens/main_screen.dart';
import 'package:coffeemanager/screens/misFincas_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/add_screen.dart';
import 'screens/panel_screen.dart';
import 'screens/login_screen.dart'; // Asegúrate de importar el LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Manager',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute:
          '/login', // El inicio de sesión debería ser la primera pantalla
      routes: {
        '/main': (context) => MainScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddScreen(),
        '/panel': (context) => PanelScreen(),
        '/misFincas': (context) => MisFincas(),
        '/administrar': (context) => AdministrarScreen(),
        '/chatIA': (context) => ChatIAScreen(),
      },
    );
  }
}
