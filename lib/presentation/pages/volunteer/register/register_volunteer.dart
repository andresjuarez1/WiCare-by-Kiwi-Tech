import 'package:flutter/material.dart';
import 'register_volunteer2.dart';

class RegisterVolunteerPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      String name = _nameController.text;
      String age = _ageController.text;
      String curp = _curpController.text;
      String phone = _phoneController.text;

      // lógica de procesamiento o envío de datos

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterVolunteerPage2()),
      );
    }
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
                        '¡Bienvenido, voluntario!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildLabel('Nombre completo'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Ingresa tu nombre completo',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre completo';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Edad'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _ageController,
                        label: 'Ingresa tu edad',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu edad';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('CURP'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _curpController,
                        label: 'Ingresa tu CURP',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu CURP';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Teléfono'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Ingresa tu teléfono',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu teléfono';
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
                            'Siguiente',
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
                'assets/progress-bar-volunteer.png',
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
