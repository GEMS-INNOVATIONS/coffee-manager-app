import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main_screen.dart'; // Importa MainScreen en lugar de HomeScreen

class LoginScreen extends StatelessWidget {
  Future<User?> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("No se seleccionó ninguna cuenta de Google.");
        return null; // El usuario cerró la ventana de selección de cuenta.
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        print("Error al obtener la autenticación de Google.");
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        print("Inicio de sesión exitoso: ${user.displayName}");
        return user;
      } else {
        print(
            "Error: No se pudo obtener el usuario después de la autenticación.");
        return null;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset('assets/images/logo.png', height: 120),
            SizedBox(height: 40),
            Text(
              'Administra todo en solo lugar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Administra tu finca de café de forma sencilla y eficiente con nuestras herramientas innovadoras.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                User? user = await _signInWithGoogle(context);
                if (user != null) {
                  Navigator.of(context).pushReplacementNamed(
                      '/main'); // Navega a MainScreen sin animación personalizada
                } else {
                  print("Error: Usuario no autenticado.");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: Usuario no autenticado.")),
                  );
                }
              },
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
              label: Text(
                'Iniciar sesión con Google',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter,
                      color: Colors.brown[800]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook,
                      color: Colors.brown[800]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram,
                      color: Colors.brown[800]),
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            Text(
              'By GEMS INNOVATIONS',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
