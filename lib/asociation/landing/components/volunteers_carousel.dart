import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:locura1/asociation/landing/asociation_landing.dart';

class VolunteersCarousel extends StatelessWidget {
  final List<Map<String, String>> imgList;
  final Function(BuildContext, String) navigateToEvent;

  VolunteersCarousel(
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
                'Voluntarios activos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssociationLandingPage(),
                    ),
                  );
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
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            item['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 20.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            item['subtitle']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
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
