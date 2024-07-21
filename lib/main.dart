import 'package:flutter/material.dart';
import './presentation/pages/login/splash_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  print('APIURL: ${dotenv.env['APIURL']}');

  runApp(MaterialApp(
    home: SplashPage(),
    debugShowCheckedModeBanner: false,
  ));
}
