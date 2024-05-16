import 'package:flutter/material.dart';
import '../register/register_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Add your authentication logic here

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
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
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Ingresa tu correo electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBCBCBC)),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
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
              TextField(
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
    );
  }

  void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }
}
