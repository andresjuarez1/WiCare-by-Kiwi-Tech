import 'package:flutter/material.dart';
import '../../userProfile/asociation_profile.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      automaticallyImplyLeading: false, 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
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
                // colocar la acción al presionar el botón
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
