import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/event_remote_data_source.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'package:locura1/presentation/pages/asociation/landing/components/events_asociation.dart';
import 'package:locura1/presentation/pages/asociation/landing/components/past_events_asociation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/navbar_asociation.dart';
import 'components/donation_part.dart';
import 'components/custom_drawer.dart';
import 'package:http/http.dart' as http;

class AssociationLandingPage extends StatefulWidget {
  @override
  _AssociationLandingPageState createState() => _AssociationLandingPageState();
}

class _AssociationLandingPageState extends State<AssociationLandingPage> {
  late EventRemoteDataSource eventRemoteDataSource;
  List<EventUnique> pastEvents = [];

  @override
  void initState() {
    super.initState();
    _initializeDataSource();
  }

  Future<void> _initializeDataSource() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');

    if (token != null && userId != null) {
      final client = http.Client();
      eventRemoteDataSource = EventRemoteDataSource(client, token);
      _fetchPastEvents(userId);
    } else {
      print('Token o userId no encontrado en SharedPreferences');
    }
  }

  Future<void> _fetchPastEvents(int userId) async {
    try {
      final events =
          await eventRemoteDataSource.getFinishedEventsForAssociation(userId);
      setState(() {
        pastEvents = events;
      });
    } catch (e) {
      print('Error fetching past events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              ActiveEventsCarousel(),
              SizedBox(height: 30),
              AllPastEventsList(pastEvents: pastEvents),
              SizedBox(height: 30),
              FooterComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
