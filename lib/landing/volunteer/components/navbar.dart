import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF5CA666),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.menu, color: Colors.white),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(
        'Bienvenido, usuario',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // botón a la página de perfil
                },
                child: Image.asset(
                  'assets/perfil_volunteer.jpg',
                  width: 35.0,
                  height: 35.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
