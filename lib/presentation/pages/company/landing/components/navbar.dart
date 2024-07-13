import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../../data/repositories/user_repository_impl.dart';
import '../../../../../domain/entities/companyProfile.dart';
import 'package:locura1/domain/use_cases/getCompanyProfile.dart';
import '../../companyProfile/company_profile.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late final GetcompanyprofileUseCase _getCompanyProfileUseCase;
  late Future<CompanyProfile?> _companyProfileFuture;

  @override
  void initState() {
    super.initState();
    _companyProfileFuture = Future.value(null);
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
      return;
    }
    setState(() {
      _companyProfileFuture = _getCompanyProfileUseCase(userId, token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5CA666),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: FutureBuilder<CompanyProfile?>(
        future: _companyProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(
              'Hola, ...',
              style: TextStyle(
                  color: Color(0xFF5CA666),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PoppinsRegular'),
            );
          } else if (snapshot.hasError) {
            return const Text(
              'Hola, error',
              style: TextStyle(
                  color: Color(0xFF5CA666),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PoppinsRegular'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text(
              'Hola, empresa',
              style: TextStyle(
                  color: Color(0xFF5CA666),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PoppinsRegular'),
            );
          }

          final companyProfile = snapshot.data!;
          return Text(
            'Hola, ${companyProfile.name}',
            style: const TextStyle(
                color: Color(0xFF5CA666),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'PoppinsRegular'),
          );
        },
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Image.asset(
                  'assets/bbva.jpg',
                  width: 35.0,
                  height: 35.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
