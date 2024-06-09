import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Editar Perfil'),
      ),
      body: Center(
        child: Text('Página de edición de perfil'),
      ),
    );
  }
}
