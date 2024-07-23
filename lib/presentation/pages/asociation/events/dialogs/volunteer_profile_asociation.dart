import 'package:flutter/material.dart';
import 'package:locura1/data/models/volunteer_event.dart';

class VolunteerDialog extends StatefulWidget {
  final Future<List<VolunteerInEvent>> volunteersFuture;

  VolunteerDialog({required this.volunteersFuture});

  @override
  _VolunteerDialogState createState() => _VolunteerDialogState();
}

class _VolunteerDialogState extends State<VolunteerDialog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VolunteerInEvent>>(
      future: widget.volunteersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(
            Text('Error: ${snapshot.error}'),
          );
          return AlertDialog(
            backgroundColor: Colors.white,
            content: const SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.0),
                    Text('No se encontraron voluntarios para este evento',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cerrar',
                  style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ],
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No volunteers available'));
        } else {
          final volunteers = snapshot.data!;
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Voluntarios'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: volunteers.map((volunteer) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VolunteerDetailPage(volunteer: volunteer),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(volunteer.profile.profilePicture),
                      ),
                      title: Text(volunteer.profile.name),
                      subtitle: Text(volunteer.profile.occupation),
                    ),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        }
      },
    );
  }
}

class VolunteerDetailPage extends StatelessWidget {
  final VolunteerInEvent volunteer;

  VolunteerDetailPage({required this.volunteer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 170.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fondo2.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.srcOver),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        transform: Matrix4.translationValues(15.0, 10.0, 0.0),
                        padding: const EdgeInsets.all(1.5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: volunteer.profile.profilePicture !=
                                  null
                              ? NetworkImage(volunteer.profile.profilePicture)
                              : const AssetImage('assets/kiwilogo-inicio.png')
                                  as ImageProvider,
                        ),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: Transform.translate(
                          offset: Offset(0, 19),
                          child: Text(
                            volunteer.profile.name,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Color(0xFF5CA666),
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Correo electrónico',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5CA666),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            volunteer.profile.email,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Teléfono',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5CA666),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            volunteer.profile.cellphone,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Género',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5CA666),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            _getGenderText(volunteer.profile.genre),
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Ocupación',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5CA666),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            volunteer.profile.occupation,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Habilidades',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5CA666),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            volunteer.profile.description ?? "",
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGenderText(String genre) {
    switch (genre) {
      case 'm':
        return 'Masculino';
      case 'f':
        return 'Femenino';
      case 'nb':
        return 'No Binario';
      default:
        return 'Género no especificado';
    }
  }
}
