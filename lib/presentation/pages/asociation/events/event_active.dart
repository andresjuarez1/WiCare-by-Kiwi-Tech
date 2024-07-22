import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/event_remote_data_source.dart';
import 'package:locura1/data/models/volunteer_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/action_buttons.dart';
import 'components/event_details.dart';
import 'components/organizer_info.dart';
import 'components/event_header.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import './map/google_maps.dart';
import 'package:http/http.dart' as http;

class EventPageActive extends StatefulWidget {
  final EventUnique event;

  EventPageActive({required this.event});

  @override
  _EventPageActiveState createState() => _EventPageActiveState();
}

class _EventPageActiveState extends State<EventPageActive> {
  late Future<List<VolunteerInEvent>> _volunteersFuture;

  @override
  void initState() {
    super.initState();
    _volunteersFuture = _fetchVolunteers();
  }

  Future<List<VolunteerInEvent>> _fetchVolunteers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    final client = http.Client();
    final eventRemoteDataSource = EventRemoteDataSource(client, token);

    return eventRemoteDataSource.getVolunteersByEventId(widget.event.id);
  }

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
              background: EventHeader(event: widget.event),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                EventDetails(event: widget.event),
                const SizedBox(height: 40),
                GoogleMapsWidget(
                  latitude: widget.event.association!.latitude,
                  longitude: widget.event.association!.longitude,
                ),
                const SizedBox(height: 40),
                OrganizerInfo(event: widget.event),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ActionButtons(volunteersFuture: _volunteersFuture),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
