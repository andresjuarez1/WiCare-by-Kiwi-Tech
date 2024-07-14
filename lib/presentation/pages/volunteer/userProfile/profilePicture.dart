import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/use_cases/updateProfilePicture.dart';

class UploadProfilePicturePage extends StatefulWidget {
  @override
  _UploadProfilePicturePageState createState() =>
      _UploadProfilePicturePageState();
}

class _UploadProfilePicturePageState extends State<UploadProfilePicturePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late final UpdateProfilePictureUseCase _updateProfilePictureUseCase;

  @override
  void initState() {
    super.initState();
    _initializeUseCase();
  }

  void _initializeUseCase() {
    final userRemoteDataSource = UserRemoteDataSource(http.Client());
    final userRepository = UserRepositoryImpl(userRemoteDataSource);
    _updateProfilePictureUseCase = UpdateProfilePictureUseCase(userRepository as UserRemoteDataSource);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfilePicture() async {
    if (_imageFile != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final int? userId = prefs.getInt('userId');

      if (userId == null || token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No se encontró userId o token en SharedPreferences')),
        );
        return;
      }

      try {
        await _updateProfilePictureUseCase;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imagen de perfil actualizada')),
        );

        Navigator.pop(context, _imageFile);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar la imagen: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, seleccione una imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Foto de Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await _pickImage(ImageSource.gallery); // Acceder a la galería al hacer tap
              },
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : AssetImage('assets/default_profile.png'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfilePicture,
              child: Text('Subir Imagen'),
            ),
          ],
        ),
      ),
    );
  }
}
