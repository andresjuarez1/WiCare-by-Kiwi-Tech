import 'package:flutter/material.dart';
import '../../postEvent/post_event.dart';
import 'package:locura1/domain/use_cases/getAssociationProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../../data/repositories/user_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:locura1/domain/entities/associationProfile.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late final GetassociationprofileUseCase _getAssociationProfileUseCase;
  late Future<AssociationProfile> _userProfileFuture;

  String _profilePictureUrl = '';
  String userName = '';

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
    _getAssociationProfileUseCase =
        GetassociationprofileUseCase(userRepository);

    if (userId == null || token == null) {
      print('Error: No se encontró userId o token en SharedPreferences');
      setState(() {
        _userProfileFuture =
            Future.error('Token o userId no encontrados en SharedPreferences');
      });
      return;
    }

    setState(() {
      _userProfileFuture = _getAssociationProfileUseCase(userId, token);
    });

    _userProfileFuture.then((profile) {
      setState(() {
        _profilePictureUrl = profile.profilePicture;
        userName = profile.name;
        print('url desde la nueva variable,$_profilePictureUrl');
      });
    }).catchError((error) {
      setState(() {
      });
      print('Error al obtener el perfil: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF5CA666),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
          Text(
            'Hola, $userName',
            style: const TextStyle(
              fontFamily: 'PoppinsRegular',
              color: Color(0xFF5CA666),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostEvent()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF5CA666),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
