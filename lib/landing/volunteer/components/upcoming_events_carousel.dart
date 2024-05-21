import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'noticia.dart';

class UpcomingEventsCarousel extends StatelessWidget {
  final List<Map<String, String>> imgList;
  final Function(BuildContext, String) navigateToEvent;

  UpcomingEventsCarousel(
      {required this.imgList, required this.navigateToEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    navigateToEvent(context, item['title']!);
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
      ],
    );
  }
}
