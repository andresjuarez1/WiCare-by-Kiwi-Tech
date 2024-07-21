import 'package:flutter/material.dart';
import 'package:locura1/presentation/pages/register/registerEnterprise/registerCompany.dart';
import '../login/login_page.dart';
import 'registerVolunteer/register_volunteer.dart';
import 'registerAsociation/registerAssociation.dart';

class RegistrationPage extends StatelessWidget {
  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _onButton1Pressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterVolunteerPage()),
    );
  }

  void _onButton2Pressed(BuildContext context) {   
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterCompanyPage()),
    );
  }

  void _onButton3Pressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterAssociationPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/wicare-logo-inicio.png',
                width: 180,
              ),
              const SizedBox(height: 40),
              const Text(
                'Selecciona una opción:',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF2E8139),
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onButton1Pressed(context),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFF2E8139)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 13.0),
                    ),
                  ),
                  child: const Text(
                    'Voluntario',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'poppinsRegular',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onButton2Pressed(context),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFF2E8139)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 13.0),
                    ),
                  ),
                  child: const Text(
                    'Empresas',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'poppinsRegular',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onButton3Pressed(context),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFF2E8139)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 13.0),
                    ),
                  ),
                  child: const Text(
                    'Asociación',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'poppinsRegular',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _navigateToLoginPage(context),
                child: const Text(
                  '¿Ya tienes una cuenta? Inicia sesión',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    fontFamily: 'poppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
