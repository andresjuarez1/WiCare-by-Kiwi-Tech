import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'Perfil',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'PoppinsRegular',
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
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/bbva.jpg'),
              ),
              SizedBox(height: 10),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'BBVA',
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5CA666),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                    Divider(color: Color.fromARGB(255, 228, 228, 228)),
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
                    SizedBox(height: 5),
                    Divider(color: Color.fromARGB(255, 228, 228, 228)),
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
                  ],
                ),
              ),
              SizedBox(height: 180),
            ],
          ),
        ),
      ),
    );
  }
}
