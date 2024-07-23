import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/companyProfile.dart';
import 'package:locura1/domain/use_cases/getCompanyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import 'package:http/http.dart' as http;
import '../../volunteer/userProfile/profilePicture.dart';
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

  void _showMapDialog(BuildContext context, double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Ubicación'),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: GoogleMapsWidget(
              latitude: latitude,
              longitude: longitude,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            child: _isLoading
                ? const CircularProgressIndicator()
                : FutureBuilder<CompanyProfile>(
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
                                  transform: Matrix4.translationValues(
                                      15.0, -20.0, 0.0),
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: _profilePictureUrl
                                            .isNotEmpty
                                        ? NetworkImage(_profilePictureUrl)
                                        : const AssetImage(
                                                'assets/kiwilogo-inicio.png')
                                            as ImageProvider,
                                  ),
                                ),
                                SizedBox(width: 25),
                                Transform.translate(
                                  offset: Offset(0, -20),
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
                            SizedBox(height: 10),
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
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      userProfile.description,
                                      style: const TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
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
                                  Center(
                                    child: SizedBox(
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _showMapDialog(
                                            context,
                                            userProfile.location.latitude,
                                            userProfile.location.longitude,
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.green),
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          padding: WidgetStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            const EdgeInsets.symmetric(
                                                vertical: 13.0),
                                          ),
                                        ),
                                        child: const Text(
                                          'Ver Ubicación',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
          ),
        ],
      ),
    );
  }
}
