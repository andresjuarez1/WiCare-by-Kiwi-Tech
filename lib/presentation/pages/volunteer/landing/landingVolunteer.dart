import 'package:flutter/material.dart';
import 'package:locura1/data/models/event_model.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/event_remote_data_source.dart';
import '../../../../domain/entities/miniEvent.dart';
import '../../../../x/prueba_textos.dart';
import 'components/navbar.dart';
import 'components/custom_drawer.dart';
import 'components/search_events.dart';
import 'components/donation_part.dart';
import 'components/new_carousel.dart';
import '../newEvent/event.dart';
import 'package:http/http.dart' as http;

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  List<MiniEvent> eventsList = [];
  //List<EventModel> eventCategory = [];
  List<Map<String, String>> attendedEvents = [
    {
      'image': 'assets/basura.jpg',
      'title': 'Recoger basura en el río',
      'location': 'Rio nilo',
    },
    {
      'image': 'assets/escuela.jpg',
      'title': 'Limpiar escuela primaria',
      'location': 'Escuela primaria "Niños héroes"',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getProfile();
    _getCategory();
  }

  Future<void> _getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final EventRemoteDataSource eventRemoteDataSource =
      EventRemoteDataSource(http.Client(), token);
      final List<MiniEvent> events =
      await eventRemoteDataSource.getAllMiniEvents();

      setState(() {
        eventsList = events;
      });
    } else {
      throw Exception('Token o userId no encontrados en SharedPreferences');
    }
  }

  Future<void> _getCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final EventRemoteDataSource eventRemoteDataSource =
      EventRemoteDataSource(http.Client(), token);
      final List<EventModel> category =
      await eventRemoteDataSource.getEventsByCategory(token);

      setState(() {
        //eventCategory = category;
      });
    } else {
      throw Exception('Token o userId no encontrados en SharedPreferences');
    }
  }

  void _navigateToNewEvent(BuildContext context, EventUnique event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewEventPage(event: event),
      ),
    );
  }

  void _onDonateConfirmed() {
    print('Donación confirmada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      drawer: CustomDrawer(attendedEvents: attendedEvents),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SearchEvents(
              onChanged: (value) {},
            ),
            SizedBox(height: 30),
            NewEventsCarousel(
              eventsList: eventsList,
              navigateToEvent: _navigateToNewEvent,
            ),
            SizedBox(height: 30),

            FooterComponent(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}