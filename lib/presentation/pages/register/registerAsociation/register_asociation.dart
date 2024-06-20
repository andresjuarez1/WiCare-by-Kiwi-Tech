import 'package:flutter/material.dart';
import '../../../../domain/entities/association.dart';
import 'register_asociation2.dart';

class RegisterAsociationPage extends StatelessWidget {
  final TextEditingController _nameCompanyController = TextEditingController();
  final TextEditingController _addressCompanyController = TextEditingController();
  final TextEditingController _foundationDateController = TextEditingController();
  final TextEditingController _representativeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      String nameCompany = _nameCompanyController.text;
      String addressCompany = _addressCompanyController.text;
      String foundationDate = _foundationDateController.text;
      String representative = _representativeController.text;


      print(nameCompany);
      print(addressCompany);
      print(foundationDate);
      print(representative);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterAsociationPage2(companyName: nameCompany,
          addressCompany: addressCompany,
          foundation: foundationDate,
          representative: representative,)),
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
                        '¡Bienvenida, Asociación!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildLabel('Nombre de la Asociación'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _nameCompanyController,
                        label: 'Ingresa el nombre de la asociación',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre de la asociación';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Domicilio'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _addressCompanyController,
                        label: 'Ingresa el domicilio de la asociación',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el domicilio de la asociación';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Fecha de Fundación'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _foundationDateController,
                        label: 'Ingresa la fecha de fundación (DD-MM-AAAA)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa la fecha de fundación de la asociación';
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
                'assets/progress-bar-asociation.png',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
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
