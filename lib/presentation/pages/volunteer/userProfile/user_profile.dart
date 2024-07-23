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
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            transform:
                                Matrix4.translationValues(15.0, 10.0, 0.0),
                            padding: const EdgeInsets.all(1.5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: userProfile.profilePicture !=
                                      null
                                  ? NetworkImage(userProfile.profilePicture!)
                                  : const AssetImage(
                                          'assets/kiwilogo-inicio.png')
                                      as ImageProvider,
                            ),
                          ),
                          SizedBox(width: 25),
                          Transform.translate(
                            offset: Offset(0, 12),
                            child: Text(
                              userProfile.name,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                color: Color(0xFF5CA666),
                                letterSpacing: 2,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                userProfile.email,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                userProfile.cellphone,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                _getGenderText(userProfile.genre),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                userProfile.occupation,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                userProfile.description,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadProfilePicturePage(),
            ),
          );
        },
        child: const Icon(Icons.camera_alt),
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
