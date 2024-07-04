import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/companyProfile.dart';
import 'package:locura1/domain/use_cases/getCompanyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/use_cases/getCompanyProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final GetcompanyprofileUseCase _getCompanyProfileUseCase;
  late Future<CompanyProfile> _userProfileFuture;
  bool _isLoading = true; // Controla el estado de carga inicial

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
      // Manejo de error o redirección si es necesario
      print('Error: No se encontró userId o token en SharedPreferences');
      setState(() {
        _userProfileFuture = Future.error('Token o userId no encontrados en SharedPreferences');
        _isLoading = false; // Finaliza la carga
      });
      return;
    }

    setState(() {
      _userProfileFuture = _getCompanyProfileUseCase(userId, token);
    });

    // Actualiza el estado de carga cuando se completa el futuro
    _userProfileFuture.then((_) {
      setState(() {
        _isLoading = false; // Finaliza la carga
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false; // Finaliza la carga
      });
      print('Error al obtener el perfil: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<CompanyProfile>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No hay datos'));
          }

          final userProfile = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/maranatha.jpg'),
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
                          userProfile.description ?? '',
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
                          userProfile.email ?? '',
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
                          userProfile.cellphone ?? '',
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
                          'Ubicación',
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
                          userProfile.location ?? '',
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
    );
  }
}
