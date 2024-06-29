import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/entities/volunteerProfile.dart';
import '../../../../domain/use_cases/getVolunteerProfile.dart';

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

    if (userId == null || token == null) {
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
        title: const Text('Perfil'),
      ),
      body: Center(
        child: FutureBuilder<VolunteerProfile>(
          future: _userProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No hay datos');
            }

            final userProfile = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/perfil_volunteer.jpg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userProfile.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5CA666),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
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
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Estudiante de la carrera en ingeniería en software con ganas de ayudar a las personas',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                            color: Color.fromARGB(255, 228, 228, 228)),
                        const Padding(
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.email,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 228, 228, 228)),
                        const Padding(
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.cellphone,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 228, 228, 228)),
                        const Padding(
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.genre == 'm'
                                ? 'Masculino'
                                : userProfile.genre == 'f'
                                    ? 'Femenino'
                                    : userProfile.genre == 'nb'
                                        ? 'No binario'
                                        : 'No especificado',
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 228, 228, 228)),
                        const Padding(
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.occupation,
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
            );
          },
        ),
      ),
    );
  }
}
