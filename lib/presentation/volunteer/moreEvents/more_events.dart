import 'package:flutter/material.dart';

class MoreEventsPage extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      'title': 'Evento 1',
      'location': 'Lugar 1',
      'description': 'Descripción del evento 1',
      'image': 'assets/carrusel-image1.png'
    },
    {
      'title': 'Evento 2',
      'location': 'Lugar 2',
      'description': 'Descripción del evento 2',
      'image': 'assets/carrusel-image1.png'
    },
    {
      'title': 'Evento 3',
      'location': 'Lugar 3',
      'description': 'Descripción del evento 3',
      'image': 'assets/carrusel-image1.png'
    },
    {
      'title': 'Evento 4',
      'location': 'Lugar 4',
      'description': 'Descripción del evento 4',
      'image': 'assets/carrusel-image1.png'
    },
    {
      'title': 'Evento 5',
      'location': 'Lugar 5',
      'description': 'Descripción del evento 5',
      'image': 'assets/carrusel-image1.png'
    },
    {
      'title': 'Evento 6',
      'location': 'Lugar 6',
      'description': 'Descripción del evento 6',
      'image': 'assets/carrusel-image1.png'
    },
  ];

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
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Text(
            'Eventos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5CA666),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Próximos eventos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 2 / 2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return EventItem(
                    title: events[index]['title']!,
                    location: events[index]['location']!,
                    description: events[index]['description']!,
                    image: events[index]['image']!,
                  );
                },
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final String image;

  EventItem({
    required this.title,
    required this.location,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
