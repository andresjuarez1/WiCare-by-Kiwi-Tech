// import 'package:flutter/material.dart';
// import 'package:locura1/domain/entities/associationProfile.dart';
// import 'package:locura1/domain/use_cases/getAssociationProfile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../data/datasources/remote/user_remote_data_source.dart';
// import '../../../../data/repositories/user_repository_impl.dart';
// import '../editProfile/edit_profile.dart';
// import 'package:http/http.dart' as http;

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   late final GetassociationprofileUseCase _getAssociationProfileUseCase;
//   late Future<AssociationProfile> _userProfileFuture;

//   @override
//   void initState() {
//     super.initState();
//     _getProfile();
//   }
//   Future <void> _getProfile() async {
//     print('Botón "Obtener info de empresa" presionado');
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('token');
//     final int? userId = prefs.getInt('userId');
//     final userRemoteDataSource = UserRemoteDataSource(http.Client());
//     final userRepository = UserRepositoryImpl(userRemoteDataSource);
//     _getAssociationProfileUseCase = GetassociationprofileUseCase(userRepository);

//     if (token != null && userId != null) {
//       final profile = await userRemoteDataSource.getProfileAssociation2(userId, token);
//       print('Perfil del usuario fin:');
//       print('jalo?');

//     } else {
//       throw Exception('Token o userId no encontrados en SharedPreferences');
//     }
//     _userProfileFuture = _getAssociationProfileUseCase(userId, token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Color(0xFF5CA666)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Center(
//           child: Text(
//             'Mi asociación',
//             style: TextStyle(
//               fontSize: 22,
//               fontFamily: 'RobotoRegular',
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF5CA666),
//             ),
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit, color: Color(0xFF5CA666)),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => EditProfilePage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body:  Center(
//         child: FutureBuilder<AssociationProfile>(
//             future: _userProfileFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (!snapshot.hasData) {
//                 return Text('No hay datos');
//               }

//               final userProfile = snapshot.data!;
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50.0,
//                       backgroundImage: AssetImage('assets/maranatha.jpg'),
//                     ),
//                     Align(
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 20.0),
//                         child: Text(
//                           userProfile.name,
//                           style: TextStyle(
//                             fontFamily: 'PoppinsRegular',
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF5CA666),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'Descripción',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF5CA666),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Text(
//                               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna. tempor incididunt ut labore et dolore magna.',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 14.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'Correo electrónico',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF5CA666),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Text(
//                               'hola@hola.com',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 14.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
//                           ),
//                           SizedBox(height: 5),
//                           Padding(
//                             padding: EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'Teléfono',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF5CA666),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Text(
//                               '12345678910',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 14.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Divider(color: Color.fromARGB(255, 228, 228, 228)),
//                           ),
//                           SizedBox(height: 5),
//                           Padding(
//                             padding: EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'Datos bancarios',
//                               style: TextStyle(
//                                 fontFamily: 'PoppinsRegular',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF5CA666),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Folio: 192039123',
//                                   style: TextStyle(
//                                     fontFamily: 'PoppinsRegular',
//                                     fontSize: 14.5,
//                                   ),
//                                   textAlign: TextAlign.justify,
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   'Banco: Banco Ejemplo',
//                                   style: TextStyle(
//                                     fontFamily: 'PoppinsRegular',
//                                     fontSize: 14.5,
//                                   ),
//                                   textAlign: TextAlign.justify,
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   'Número de cuenta: 1234567890',
//                                   style: TextStyle(
//                                     fontFamily: 'PoppinsRegular',
//                                     fontSize: 14.5,
//                                   ),
//                                   textAlign: TextAlign.justify,
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: _getProfile,
//                                   child: Text('Obtener info'),
//                                 ),

//                               ],
//                             ),
//                           ),

//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }


//         ),
//       ),
//     );
//   }
// }
