// lib/presentation/profile_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/entities/volunteerProfile.dart';
import '../../../../domain/use_cases/getVolunteerProfile.dart';
//GetvolunteerprofileUseCase
//VolunteerProfile

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final GetvolunteerprofileUseCase _getVolunteerProfileUseCase;
  late Future<VolunteerProfile> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');

    final userRemoteDataSource = UserRemoteDataSource(http.Client());
    final userRepository = UserRepositoryImpl(userRemoteDataSource);
    _getVolunteerProfileUseCase = GetvolunteerprofileUseCase(userRepository);

    // Aquí puedes manejar el caso en que userId o token sean nulos
    if (userId == null || token == null) {
      // Manejo de error o redirección si es necesario
      print('Error: No se encontró userId o token en SharedPreferences');
      return;
    }
    setState(() {
      _userProfileFuture = _getVolunteerProfileUseCase(userId, token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: FutureBuilder<VolunteerProfile>(
          future: _userProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No hay datos');
            }

            final userProfile = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/perfil_volunteer.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userProfile.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5CA666),
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Descripción',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5CA666),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna. tempor incididunt ut labore et dolore magna.',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(color: Color.fromARGB(255, 228, 228, 228)),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
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
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.email,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Color.fromARGB(255, 228, 228, 228)),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
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
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.cellphone,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Color.fromARGB(255, 228, 228, 228)),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
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
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.genre,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Color.fromARGB(255, 228, 228, 228)),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
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
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.occupation,
                            style: TextStyle(
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
            );
          },
        ),
      ),
    );
  }
}