import 'package:coffeemanager/screens/administrar_screen.dart';
import 'package:coffeemanager/screens/chat_ia_screen.dart';
import 'package:coffeemanager/screens/fincaDetail_screen.dart';
import 'package:coffeemanager/screens/manager_screen.dart';
import 'package:coffeemanager/screens/misFincas_screen.dart';
import 'package:coffeemanager/screens/perfil_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa FirebaseAuth
import 'screens/home_screen.dart';
import 'screens/add_screen.dart';
import 'screens/panel_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/login_screen.dart'; // Asegúrate de importar el LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Establece el idioma de Firebase Auth a español
  FirebaseAuth.instance.setLanguageCode('es').then((_) {
    // Imprime el idioma configurado para confirmar
    print('Idioma configurado: ${FirebaseAuth.instance.languageCode}');
  }).catchError((error) {
    print('Error al establecer el idioma: $error');
  });

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
        '/perfil': (context) => PerfilScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddScreen(),
        '/panel': (context) => PanelScreen(),
        '/misFincas': (context) => MisFincas(),
        '/fincaDetail': (context) => FincaDetail(),
        '/administrar': (context) => AdministrarScreen(),
        '/chatIA': (context) => ChatIAScreen(),
      },
    );
  }
}
