import 'package:flutter/material.dart';
import '../register/register_page.dart';
import '../volunteer/landing/landingVolunteer.dart';
import '../company/landing/company_landing.dart';
import '../asociation/landing/asociation_landing.dart';
import '../../../../domain/use_cases/login_user.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginUser _loginUser = LoginUser();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;

      final user = await _loginUser.call(email, password);

      if (user != null) {
        final data = user.email;
        String role = user.role;

        if (role == 'volunteer') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VolunteerPage()),
          );
        } else if (role == 'company') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CompanyLandingPage()),
          );
        } else if (role == 'association') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AssociationLandingPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Usuario desconocido')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Credenciales incorrectas')),
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
      backgroundColor: Colors.white,
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
                  const Row(
                    children: [
                      Text(
                        'Correo electrónico',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF2E8139),
                            fontFamily: 'PoppinsRegular'),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Ingresa tu correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFBCBCBC),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                    enableInteractiveSelection: false,
                    autocorrect: false,
                    enableSuggestions: false,
                    autofillHints: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu correo electrónico';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  const Row(
                    children: [
                      Text(
                        'Contraseña',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF2E8139),
                            fontFamily: 'PoppinsRegular'),
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
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFBCBCBC),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
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
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Color(0xFF2E8139)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 13.0),
                        ),
                      ),
                      child: const Text(
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
                      margin: const EdgeInsets.only(left: 0.0),
                      child: const Text(
                        '¿No estás registrado? Regístrate',
                        style: TextStyle(fontSize: 14.0, color: Colors.blue, fontFamily: 'PoppinsRegular'),
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
