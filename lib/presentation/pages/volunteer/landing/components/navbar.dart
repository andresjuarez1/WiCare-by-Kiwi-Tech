import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../../data/repositories/user_repository_impl.dart';
import '../../../../../domain/entities/volunteerProfile.dart';
import '../../../../../domain/use_cases/getVolunteerProfile.dart';
import '../../userProfile/user_profile.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late final GetvolunteerprofileUseCase _getVolunteerProfileUseCase;
  late Future<VolunteerProfile?> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = Future.value(null);
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
      title: FutureBuilder<VolunteerProfile?>(
        future: _userProfileFuture,
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
              'Hola, usuario',
              style: TextStyle(
                  color: Color(0xFF5CA666),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PoppinsRegular'),
            );
          }

          final userProfile = snapshot.data!;
          return Text(
            'Hola, ${userProfile.name}',
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
                child: FutureBuilder<VolunteerProfile?>(
                  future: _userProfileFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.account_circle_outlined);
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Icon(Icons.account_circle_outlined);
                    }

                    final userProfile = snapshot.data!;
                    return CircleAvatar(
                      backgroundImage: userProfile.profilePicture != null
                          ? NetworkImage(userProfile.profilePicture!)
                          : AssetImage('assets/default_profile.png'),
                      radius: 15,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
