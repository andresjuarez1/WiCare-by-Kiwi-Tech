import 'package:flutter/material.dart';

class VolunteerDetailsPage extends StatelessWidget {
  final String volunteerName;
  final String imageUrl;

  VolunteerDetailsPage({required this.volunteerName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5CA666)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 60.0),
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
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(height: 20),
              Text(
                volunteerName,
                style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5CA666),
                ),
              ),
              const SizedBox(height: 15),
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
                    const SizedBox(height: 10),
                    const Text(
                      'Samuel garcía presidente de nuevo león quiere ayudar a la comunidad',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    const SizedBox(height: 5),
                    const Text(
                      'Correo electrónico',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5CA666),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'samuel@gmail.com',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    const SizedBox(height: 5),
                    const Text(
                      'Teléfono',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5CA666),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '12345678910',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFF5CA666),
                          ),
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 20.0),
                          ),
                        ),
                        child: const Text(
                          'Aceptar ayuda',
                          style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
