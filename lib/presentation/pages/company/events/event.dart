import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'components/action_buttons.dart';
import 'components/event_details.dart';
import 'components/organizer_info.dart';
import 'components/event_header.dart';
import './map/google_maps.dart';

class EventPage extends StatelessWidget {
  final EventUnique event;

  EventPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 1,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: EventHeader(event: event),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                EventDetails(event: event),
                SizedBox(height: 40),
                GoogleMapsWidget(
                  latitude: event.association!.latitude,
                  longitude: event.association!.longitude,
                ),
                const SizedBox(height: 40),
                OrganizerInfo(event: event),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ActionButtons(event: event),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
