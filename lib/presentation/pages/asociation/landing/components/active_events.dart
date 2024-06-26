import 'package:flutter/material.dart';

class ActiveEvents extends StatelessWidget {
  final List<Map<String, String>> activeEvents;
  final Function(BuildContext, String) navigateToEvent;

  ActiveEvents({required this.activeEvents, required this.navigateToEvent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tus eventos activos',
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5CA666),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeEvents.length,
              itemBuilder: (BuildContext context, int index) {
                final event = activeEvents[index];
                return GestureDetector(
                  onTap: () {
                    navigateToEvent(context, event['title']!);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(event['image']!),
                        fit: BoxFit.cover,
                        //opacar la imagen
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            event['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event['description']!,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
