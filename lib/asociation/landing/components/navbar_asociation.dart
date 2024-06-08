import 'package:flutter/material.dart';
import '../../userProfile/asociation_profile.dart';
import '../../../login/login_page.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white, 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Color(0xFF5CA666)),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Text(
            'Bienvenido, usuario',
            style: TextStyle(
              color: Color(0xFF5CA666),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                // Colocar la acción al presionar el botón
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF5CA666),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
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
            // Aquí puedes agregar más opciones si es necesario
          ],
        ),
      ),
    );
  }
}
