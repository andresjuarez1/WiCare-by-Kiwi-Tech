import 'package:flutter/material.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/use_cases/register_association_user.dart';
import '../../../../domain/entities/association.dart';
import 'package:http/http.dart' as http;

import '../../login/login_page.dart';

class RegisterAsociationPage4 extends StatelessWidget {
  final String phone;
  final String rfc;
  final String description;
  final String representative;
  final String companyName;
  final String addressCompany;
  final String foundation;
  final String selectedSocial;
  final String nameManager;
  final String position;
  final String phoneManager;
  final String addressManager;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterAsociationPage4({required this.companyName,
    required this.addressCompany,
    required this.foundation,
    required this.representative,
    required this.phone,
    required this.rfc,
    required this.description,
    required this.selectedSocial,
    required this.nameManager,
    required this.position,
    required this.phoneManager,
    required this.addressManager});
  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;
      final association = Association(
        name_company: companyName,
        address_company: addressCompany,
        foundationDate: foundation,
        representative: representative,
        socialReasons: selectedSocial,
        description: description,
        phone_company: phone,
        rfc: rfc,
        name_manager: nameManager,
        position_manager: position,
        cellphone_manager: phoneManager,
        address_manager: addressManager,
        email: _emailController.text,
        password: _passwordController.text,
      );

      try {
        print('Intentando registrar association: ${association.email}');

        final remoteDataSource = UserRemoteDataSource(http.Client());
        final repository = UserRepositoryImpl(remoteDataSource);
        final registerVolunteerUseCase = RegisterAssociationUseCase(repository);
        await registerVolunteerUseCase.execute(association);

        print('Usuario registrado correctamente: ${association.email}');
        _showSuccessDialog(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (error) {
        print('Error al registrar usuario: $error');
        //_showErrorDialog(error.toString());
      }

    }
  }

  void _showSuccessDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registro Exitoso'),
          content: Text('Tu cuenta de asociacion ha sido creada exitosamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/wicare-logo-inicio.png',
                        width: 180,
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        'Crea tu cuenta',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildLabel('Correo Electrónico'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Ingresa tu correo electrónico',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu correo electrónico';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Contraseña'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Ingresa tu contraseña',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Confirmar Contraseña'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirma tu contraseña',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirma tu contraseña';
                          }
                          if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: false, 
                            onChanged: (value) {
                            },
                          ),
                          Text(
                            'Acepto los términos y condiciones',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _submitForm(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(vertical: 13.0),
                            ),
                          ),
                          child: Text(
                            'Crear Cuenta',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'assets/progress-bar-empresa4.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF2E8139)),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, bool obscureText = false, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBCBCBC)),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      validator: validator,
    );
  }
}
