import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                'Mi perfil',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/perfil_volunteer.jpg'),
              ),
              SizedBox(height: 20),
              Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Christian Busteros',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5CA666)),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Descripción',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5CA666)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua, lorem ipsum dolor sit amet,',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        width: 318,
                        height: 2,
                        color: Color.fromARGB(255, 228, 228, 228),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Correo electrónico',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5CA666)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'hola@hola.com',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        width: 318,
                        height: 2,
                        color: Color.fromARGB(255, 228, 228, 228),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Teléfono',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5CA666)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        '12345678910',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        width: 318,
                        height: 2,
                        color: Color.fromARGB(255, 228, 228, 228),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Género',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5CA666)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'Masculino',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        width: 318,
                        height: 2,
                        color: Color.fromARGB(255, 228, 228, 228),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Ocupación',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5CA666)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'Estudiante',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  'Editar info',
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
      ),
    );
  }
}
