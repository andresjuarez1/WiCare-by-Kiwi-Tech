import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../domain/use_cases/updateProfilePicture.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';

class UploadProfilePicturePage extends StatefulWidget {
  @override
  _UploadProfilePicturePageState createState() =>
      _UploadProfilePicturePageState();
}

class _UploadProfilePicturePageState extends State<UploadProfilePicturePage> {
  File? _image;
  late final UpdateProfilePictureUseCase _updateProfilePictureUseCase;

  @override
  void initState() {
    super.initState();
    final userRemoteDataSource = UserRemoteDataSource(http.Client());
    final userRepository = UserRepositoryImpl(userRemoteDataSource);
    _updateProfilePictureUseCase = UpdateProfilePictureUseCase(userRepository);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfilePicture() async {
    if (_image != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');
      final String? token = prefs.getString('token');

      if (userId == null || token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: userId o token no encontrados')),
        );
        return;
      }

      try {
        await _updateProfilePictureUseCase.execute(userId, _image!, token);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imagen de perfil actualizada con éxito')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar la imagen de perfil: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se seleccionó ninguna imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Imagen de Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Imagen de perfil',
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF5CA666)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _image != null
                      ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  )
                      : Center(
                    child: Text(
                      'Selecciona una imagen',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
