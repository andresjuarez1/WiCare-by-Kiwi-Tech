import 'package:flutter/material.dart';
import 'register_enterprise2.dart';

class RegisterEnterprisePage extends StatefulWidget {
  @override
  _RegisterEnterprisePageState createState() => _RegisterEnterprisePageState();
}

class _RegisterEnterprisePageState extends State<RegisterEnterprisePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _creationDateController = TextEditingController();
  final TextEditingController _representativeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void _submitForm(BuildContext context) {
  if (_formKey.currentState?.validate() ?? false) {
    String name = _nameController.text;
    String address = _addressController.text;
    String creationDate = _creationDateController.text;
    String representative = _representativeController.text;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterEnterprisePage2()),
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
                        '¡Registro de Empresa!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildLabel('Nombre de la Empresa'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Ingresa el nombre de la empresa',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre de la empresa';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Domicilio'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _addressController,
                        label: 'Ingresa el domicilio de la empresa',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el domicilio de la empresa';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Fecha de Creación'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _creationDateController,
                        label: 'Ingresa la fecha de creación (DD/MM/AAAA)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa la fecha de creación de la empresa';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Representante Legal o Gerente'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _representativeController,
                        label: 'Ingresa el nombre del representante legal o gerente',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre del representante legal o gerente';
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
                'assets/progress-bar-empresa.png',
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
