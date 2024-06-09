import 'package:flutter/material.dart';
import 'components/action_buttons.dart';
import 'components/event_details.dart';
import 'components/organizer_info.dart';
import 'components/event_header.dart';

class EventPageActive extends StatelessWidget {
  final String eventTitle;

  EventPageActive({required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 1,
            flexibleSpace: FlexibleSpaceBar(
              background: EventHeader(eventTitle: eventTitle),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                EventDetails(),
                SizedBox(height: 40),
                OrganizerInfo(),
                SizedBox(height: 30),
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
