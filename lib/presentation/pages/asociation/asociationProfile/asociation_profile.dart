import 'package:flutter/material.dart';
import '../editProfile/edit_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF5CA666)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'Mi asociación',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'RobotoRegular',
              fontWeight: FontWeight.w600,
              color: Color(0xFF5CA666),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Color(0xFF5CA666)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/maranatha.jpg'),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Iglesia de San Juan',
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5CA666),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Descripción',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5CA666),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna. tempor incididunt ut labore et dolore magna.',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Correo electrónico',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5CA666),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'hola@hola.com',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Teléfono',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5CA666),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '12345678910',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Datos bancarios',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5CA666),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Folio: 192039123',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Banco: Banco Ejemplo',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Número de cuenta: 1234567890',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),

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
