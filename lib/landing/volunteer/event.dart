import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  final String eventTitle;

  EventPage({required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/carrusel-image1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EVENTO',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5CA666),
                          letterSpacing: 4.0,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        eventTitle,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Sociedad ambiental',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Domingo 12 de mayo - 6:00 pm',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5CA666),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Descripción del evento',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel pretium libero. Donec sit amet lacus sit amet orci tristique eleifend sed in velit. Sed a lobortis ipsum, non finibus justo. Donec ac gravida justo. ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Información del encargado',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  'assets/perfil_volunteer.jpg',
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Christian Bumteros',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // acción cuando se presiona el botón "Me Apunto"
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF2E8139),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(80, 55),
                              ),
                            ),
                            child: Text(
                              'Me Apunto',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              // acción cuando se presiona el botón "Donar"
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF2E8139),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(80, 55),
                              ),
                            ),
                            child: Text(
                              'Donar',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
