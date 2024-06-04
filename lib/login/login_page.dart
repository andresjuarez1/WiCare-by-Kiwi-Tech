import 'package:flutter/material.dart';
import '../register/register_page.dart';
import '../volunteer/landing/landingVolunteer.dart';
import '../company/landing/company_landing.dart';
import '../asociation/landing/asociation_landing.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username.contains("asociacion")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AssociationLandingPage()),
        );
      } else if (username.contains("voluntario")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VolunteerPage()),
        );
      } else if (username.contains("empresa")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompanyLandingPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario no reconocido')),
        );
      }
    }
  }

  void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Image.asset(
                    'assets/wicare-logo-inicio.png',
                    width: 180.0,
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    children: [
                      Text(
                        'Correo electrónico',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF2E8139)),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Ingresa tu correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBCBCBC)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu correo electrónico';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        'Contraseña',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF2E8139)),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Ingresa tu contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBCBCBC)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu contraseña';
                      }
                      return null;
                    },
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
                        'Ingresa',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => _navigateToRegistrationPage(context),
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          '¿No estás registrado? Regístrate',
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}