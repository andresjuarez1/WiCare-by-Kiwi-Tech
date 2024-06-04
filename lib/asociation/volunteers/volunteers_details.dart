import 'package:flutter/material.dart';

class VolunteerDetailsPage extends StatelessWidget {
  final String volunteerName;
  final String imageUrl;

  VolunteerDetailsPage({required this.volunteerName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF5CA666)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Detalles del voluntario',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5CA666),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage(imageUrl),
            ),
            SizedBox(height: 20),
            Text(
              volunteerName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5CA666),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua, lorem ipsum dolor sit amet.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Correo electrónico',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'hola@hola.com',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Teléfono',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '12345678910',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Acción al hacer clic en el botón
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF5CA666),
                ),
              ),
              child: Text(
                'Contactar voluntario',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
