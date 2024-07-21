import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:locura1/presentation/pages/volunteer/userProfile/profilePicture.dart';
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
    _userProfileFuture = _initializeProfile();
  }

  Future<VolunteerProfile> _initializeProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');

    final userRemoteDataSource = UserRemoteDataSource(http.Client());
    final userRepository = UserRepositoryImpl(userRemoteDataSource);
    _getVolunteerProfileUseCase = GetvolunteerprofileUseCase(userRepository);

    if (userId == null || token == null) {
      print('Error: No se encontró userId o token en SharedPreferences');
      return Future.error('No se encontró userId o token en SharedPreferences');
    }

    return _getVolunteerProfileUseCase(userId, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w600,
            color: Color(0xFF5CA666),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadProfilePicturePage(),
                ),
              );
            },
          ),
        ],
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
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: userProfile.profilePicture != null
                        ? NetworkImage(userProfile.profilePicture!)
                        : AssetImage('assets/kiwilogo-inicio.png')
                            as ImageProvider,
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
                        const SizedBox(height: 5),
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
                            _getGenderText(userProfile.genre),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            userProfile.id.toString(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la página de subir imagen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadProfilePicturePage(),
            ),
          );
        },
        child: Icon(Icons.camera_alt),
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
