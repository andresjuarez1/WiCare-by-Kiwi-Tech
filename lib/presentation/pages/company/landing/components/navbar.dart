import 'package:flutter/material.dart';
import '../../companyProfile/company_profile.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, 
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
        'Bienvenia, empresa',
        style: TextStyle(color: Color(0xFF5CA666), fontSize: 20, fontWeight: FontWeight.w600),
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
                  // Navegar a la página de perfil
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Image.asset(
                  'assets/bbva.jpg',
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