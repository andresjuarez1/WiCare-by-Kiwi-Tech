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
        title: const Center(
          child: Text(
            'Voluntario',
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5CA666),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
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
                style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5CA666),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5CA666),
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet.',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    SizedBox(height: 5),
                    const Text(
                      'Correo electrónico',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5CA666),
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'hola@hola.com',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    SizedBox(height: 5),
                    const Text(
                      'Teléfono',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5CA666),
                      ),
                    ),
                    SizedBox(height: 5),
                    const Text(
                      '12345678910',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Color(0xFF5CA666),
                          ),
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 20.0),
                          ),
                        ),
                        child: const Text(
                          'Contactar voluntario',
                          style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
