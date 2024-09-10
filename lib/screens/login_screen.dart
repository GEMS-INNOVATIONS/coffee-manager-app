import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  // Controlador de la animación
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Inicializamos el controlador con duración de 3 segundos
    _fadeController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true); // Repite la animación de forma cíclica

    // Definimos una animación que cambie la opacidad de 0.5 a 1
    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  // Método para iniciar sesión con Google
  Future<User?> _signInWithGoogle(BuildContext context) async {
    try {
      print('Iniciando sesión con Google...');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Inicio de sesión cancelado por el usuario.');
        return null;
      }

      print('Usuario de Google seleccionado: ${googleUser.displayName}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        print('Inicio de sesión exitoso para el usuario: ${user.displayName} (${user.email})');
        
        // Redirigir al usuario a la pantalla principal inmediatamente
        Navigator.of(context).pushReplacementNamed('/main');
        
        // Ejecutar la creación del usuario en la base de datos en segundo plano
        Future.microtask(() => _createUserInDatabase(user));
        
        return user;
      } else {
        print('Error: No se pudo obtener el usuario después de iniciar sesión con Google.');
        return null;
      }
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
      return null;
    }
  }

  // Método para crear el usuario en la base de datos en segundo plano
  Future<void> _createUserInDatabase(User user) async {
    print('Iniciando el proceso para crear el usuario en la base de datos...');
    final url = Uri.parse('https://coffee-manager-backend.onrender.com/users');
    final body = {
      "nombre": user.displayName ?? "Nombre desconocido",
      "apellido": "",
      "celular": "",
      "correo": user.email,
      "cedula": "",
      "imagen_perfil": user.photoURL ?? "default.jpg",
      "tipo_usuario": "admin",
      "id_finca": "null",
      "id_pase": "null",
      "uuid": user.uid,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        print("Usuario creado exitosamente en la base de datos.");
      } else {
        print(
            "Error al crear el usuario: Código de estado ${response.statusCode}, Respuesta: ${response.body}");
      }
    } catch (e) {
      print("Error en la solicitud HTTP para crear el usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown[600]!, Colors.brown[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Logo más grande sin sombra
              Image.asset(
                'assets/images/logo.png',
                height: 160, // Tamaño aumentado
              ),
              SizedBox(height: 40),
              // Título con animación constante de respiración
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Administra todo en solo lugar',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Administra tu finca de café de forma sencilla y eficiente con nuestras herramientas innovadoras.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              // Botón de Google con sombra suave
              ElevatedButton.icon(
                onPressed: () async {
                  print('Botón de inicio de sesión con Google presionado.');
                  User? user = await _signInWithGoogle(context);
                  if (user != null) {
                    print('Redirigiendo a la pantalla principal...');
                    // Redirigir al usuario a la pantalla principal inmediatamente
                    Navigator.of(context)
                        .pushReplacementNamed('/main'); // Redirigir a MainScreen
                  } else {
                    print('Error: Usuario no autenticado.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: Usuario no autenticado.")),
                    );
                  }
                },
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
                label: Text(
                  'Iniciar sesión con Google',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[600], // Color de Google
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5, // Sombra para elevar el botón
                  shadowColor: Colors.black.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 20),
              // Redes sociales con un espacio mejorado
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:
                        FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:
                        FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              Spacer(),
              // "By" con imagen pequeña
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By ',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  Image.asset(
                    'assets/images/logo_small.png', // Añade tu pequeña imagen aquí
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
