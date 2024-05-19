import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../login/login_page.dart';
import 'noticia.dart';

class VolunteerPage extends StatelessWidget {
  final List<Map<String, String>> imgList = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento 1',
      'subtitle': 'Descripción del evento 1'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento 2',
      'subtitle': 'Descripción del evento 2'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento 3',
      'subtitle': 'Descripción del evento 3'
    },
  ];

  void _navigateToEvent(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(eventTitle: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
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
          'Bienvenido, usuario',
          style: TextStyle(color: Colors.black, fontSize: 18),
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
                    // botón a la página de perfil
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
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFD3FFD4),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 60.0),
              Container(
                color: Color(0xFFD3FFD4),
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/wicare-logo-inicio.png',
                    width: 150,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.grey[300],
              thickness: 1.0,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar eventos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                ),
                onChanged: (value) {
                  // acción al cambiar el texto del campo de búsqueda
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Próximos eventos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5CA666),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // acción del botón ver más
                    },
                    child: Text(
                      'Ver más',
                      style: TextStyle(fontSize: 14, color: Color(0xFF717171)),
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imgList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        _navigateToEvent(context, item['title']!);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                          ),
                          Positioned(
                            bottom: 30.0,
                            left: 20.0,
                            child: Text(
                              item['title']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.0,
                            left: 20.0,
                            child: Text(
                              item['subtitle']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('Aquí se mostrarán los eventos'),
            ),
          ],
        ),
      ),
    );
  }
}
