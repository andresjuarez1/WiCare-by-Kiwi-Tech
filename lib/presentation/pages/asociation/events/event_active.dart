import 'package:flutter/material.dart';
import 'components/action_buttons.dart';
import 'components/event_details.dart';
import 'components/organizer_info.dart';
import 'components/event_header.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import './map/google_maps.dart';

class EventPageActive extends StatelessWidget {
  final EventUnique event;

  EventPageActive({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 1,
            pinned: true,
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
                SizedBox(height: 40),
                OrganizerInfo(event: event),
                SizedBox(height: 40),
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