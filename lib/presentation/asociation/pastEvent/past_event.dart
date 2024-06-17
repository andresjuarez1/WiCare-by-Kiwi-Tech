import 'package:flutter/material.dart';
import 'components/event_header.dart';
import 'components/event_description.dart';
import 'components/action_buttons_past.dart';

class EventDetailsPage extends StatelessWidget {
  final String eventTitle;
  final String eventImage;
  final String eventLocation;
  final String eventDescription;

  EventDetailsPage({
    required this.eventTitle,
    required this.eventImage,
    required this.eventLocation,
    required this.eventDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 1,
            flexibleSpace: FlexibleSpaceBar(
              background: EventHeader(
                eventTitle: eventTitle,
                eventImage: eventImage,
                eventLocation: eventLocation,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: EventDescription(
                    eventTitle: eventTitle,
                    eventLocation: eventLocation,
                    eventDescription: eventDescription,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ActionButtons(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
