import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/companyProfile.dart';
import 'package:locura1/domain/use_cases/getCompanyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import 'package:http/http.dart' as http;
import '../map/google_maps.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final GetcompanyprofileUseCase _getCompanyProfileUseCase;
  late Future<CompanyProfile> _userProfileFuture;
  bool _isLoading = true;
  String _profilePictureUrl = '';

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
    _getCompanyProfileUseCase = GetcompanyprofileUseCase(userRepository);

    if (userId == null || token == null) {
      print('Error: No se encontró userId o token en SharedPreferences');
      setState(() {
        _userProfileFuture =
            Future.error('Token o userId no encontrados en SharedPreferences');
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _userProfileFuture = _getCompanyProfileUseCase(userId, token);
    });

    _userProfileFuture.then((profile) {
      setState(() {
        _isLoading = false;
        _profilePictureUrl = profile.profilePicture;
        print('URL de perfil: $_profilePictureUrl');
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      print('Error al obtener el perfil: $error');
    });
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<CompanyProfile>(
              future: _userProfileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No hay datos'));
                }

                final userProfile = snapshot.data!;
                _profilePictureUrl = userProfile.profilePicture;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _profilePictureUrl.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                _profilePictureUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  print('Error cargando imagen: $error');
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                userProfile.description,
                                style: const TextStyle(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                'Ubicación',
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
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                '${userProfile.location.latitude}, ${userProfile.location.longitude}',
                                style: const TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 14.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Mapa',
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
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GoogleMapsWidget(
                                latitude: userProfile.location.latitude,
                                longitude: userProfile.location.longitude,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
