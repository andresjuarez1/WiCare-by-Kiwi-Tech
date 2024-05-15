import 'package:flutter/material.dart';
//import 'home_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // lógica de autenticación

    //Navigator.pushReplacement(
    //context,
    //MaterialPageRoute(builder: (context) => HomePage()),
    //);
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('assets/wicare-logo-inicio.png'),

              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'Correo electrónico',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),

              SizedBox(height: 10.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Ingresa tu correo electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'Contraseña',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

