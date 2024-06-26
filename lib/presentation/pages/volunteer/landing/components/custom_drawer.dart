import 'package:flutter/material.dart';
import '../../../volunteer/assistedEvents/attended_events_page.dart';
import '../../../login/login_page.dart';
import '../../companiesList/companies_page.dart';

class CustomDrawer extends StatelessWidget {
  final List<Map<String, String>> attendedEvents;

  const CustomDrawer({required this.attendedEvents, Key? key})
      : super(key: key);

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
              leading: Icon(Icons.event),
              title: Text('Eventos Asistidos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AttendedEventsPage(attendedEvents: attendedEvents),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Ver Empresas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompaniesPage(),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.menu_book),
            //   title: Text('Educación'),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.medical_services_outlined),
            //   title: Text('Salud'),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.people),
            //   title: Text('Ámbito social'),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.nature_people),
            //   title: Text('Ámbito natural'),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.pets),
            //   title: Text('Animales'),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            SizedBox(height: 400.0),
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
