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
          Text(
            'Tus eventos activos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event['description']!,
                            style: TextStyle(
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
