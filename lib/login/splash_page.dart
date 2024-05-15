import 'package:flutter/material.dart';
import 'login_page.dart'; // Importa la página de inicio de sesión

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3FFD4),
      body: Center(
        child: Image.asset(
          'assets/logo-inicio.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
