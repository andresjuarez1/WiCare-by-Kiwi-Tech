import 'package:flutter/material.dart';
import '../../../../login/login_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFFFFFFF),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 70.0),
            Container(
              color: Color(0xFFFFFFFF),
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/wicare-logo-inicio.png',
                  width: 150,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Educación'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.medical_services_outlined),
              title: Text('Salud'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Ámbito social'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.nature_people),
              title: Text('Ámbito natural'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text('Animales'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 230.0),
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
