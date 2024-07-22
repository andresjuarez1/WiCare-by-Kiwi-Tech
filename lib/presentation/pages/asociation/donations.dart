import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/donation_event_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/donation.dart';

class PendingDonationsPage extends StatefulWidget {
  @override
  _PendingDonationsPageState createState() => _PendingDonationsPageState();
}

class _PendingDonationsPageState extends State<PendingDonationsPage> {
  Future<List<Donation>>? _pendingDonations;
  int _pendingDonationsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchPendingDonations();
  }

  Future<void> _fetchPendingDonations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');

    if (userId == null || token == null) {
      print('Error: No se encontró userId o token en SharedPreferences');
      return;
    }

    final donations = await getDonationsPending(userId, token);
    setState(() {
      _pendingDonations = Future.value(donations);
      _pendingDonationsCount = donations.length;
    });
  }

  void _confirmDonation(int donationId) async {
    print('di click en confirmar');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print('Error: No se encontró token en SharedPreferences');
      return;
    }

    await updateDonationStatus(donationId, 'Confirmed', token);
    _fetchPendingDonations(); // Refresca la lista después de la actualización
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones Pendientes'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '$_pendingDonationsCount',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Donation>>(
        future: _pendingDonations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay donaciones pendientes.'));
          } else {
            final donations = snapshot.data!;
            return ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation = donations[index];
                return ListTile(
                  title: Text(donation.companyName),
                  subtitle: Text('Estatus: ${donation.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () => _confirmDonation(donation.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
