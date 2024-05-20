import 'package:flutter/material.dart';
import '../../../login/login_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFD3FFD4),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 60.0),
            Container(
              color: Color(0xFFD3FFD4),
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/wicare-logo-inicio.png',
                  width: 150,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
