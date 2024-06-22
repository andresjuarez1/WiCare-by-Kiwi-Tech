import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importa el paquete dotenv
import '../../login/login_page.dart';

class RegisterVolunteerPage extends StatefulWidget {
  @override
  _RegisterVolunteerPageState createState() => _RegisterVolunteerPageState();
}

class _RegisterVolunteerPageState extends State<RegisterVolunteerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _cellphoneController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _occupations = [
    'Estudiante',
    'Trabajador',
    'Desempleado',
    'Jubilado',
    'Otro'
  ];

  final Map<String, String> _genderMap = {
    'Masculino': 'm',
    'Femenino': 'f',
    'No binario': 'nb',
    'Prefiero no decir': 'Prefiero no decir',
  };

  String? _selectedOccupation;
  String? _selectedGenre;
  bool _termsAccepted = false;

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String name = _nameController.text;
      String age = _ageController.text;
      String curp = _curpController.text;
      String cellphone = _cellphoneController.text;
      String postal = _postalController.text;
      String address = _addressController.text;
      String occupation = _selectedOccupation ?? '';
      String genre = _genderMap[_selectedGenre] ?? '';
      String email = _emailController.text;
      String password = _passwordController.text;

      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'curp': curp,
        'occupation': occupation,
        'age': age,
        'postal': postal,
        'cellphone': cellphone,
        'address': address,
        'genre': genre,
      };

      String body = json.encode(data);

      Uri url = Uri.parse('${dotenv.env['API_URL']}/user/volunteer');

      try {
        print('Sending request to $url');
        print('Request body: $body');

        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          throw Exception('Failed to register volunteer: ${response.body}');
        }
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Hubo un problema al registrar el voluntario. Por favor, inténtalo de nuevo más tarde.'),
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
                      SizedBox(height: 60.0),
                      Image.asset(
                        'assets/wicare-logo-inicio.png',
                        width: 180,
                      ),
                      SizedBox(height: 25.0),
                      const Text(
                        '¡Bienvenido, voluntario!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      _buildLabel('Nombre completo'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Ingresa tu nombre completo',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre completo';
                          } else if (RegExp(r'[0-9]').hasMatch(value)) {
                            return 'El nombre no debe contener números';
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
                          } else if (int.tryParse(value) == null) {
                            return 'Por favor, ingresa un número válido';
                          } else if (value.length > 3) {
                            return 'La edad no debe tener más de 3 dígitos';
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
                          } else if (value.length != 18) {
                            return 'La CURP debe tener 18 caracteres';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Teléfono'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _cellphoneController,
                        label: 'Ingresa tu teléfono',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu teléfono';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'El número telefónico debe tener 10 dígitos';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Código Postal'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _postalController,
                        label: 'Ingresa tu código postal',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu código postal';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Domicilio'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _addressController,
                        label: 'Ingresa tu domicilio',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu domicilio';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Ocupación'),
                      SizedBox(height: 5.0),
                      _buildOccupationDropdown(),
                      SizedBox(height: 10.0),
                      _buildLabel('Género'),
                      SizedBox(height: 5.0),
                      _buildGenderDropdown(),
                      SizedBox(height: 10.0),
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
                            value: _termsAccepted,
                            onChanged: (value) {
                              setState(() {
                                _termsAccepted = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Acepto los términos y condiciones',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _submitForm(context),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Color(0xFF2E8139)),
                            shape: WidgetStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
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
                    ],
                  ),
                ),
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
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2E8139)),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
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

  Widget _buildOccupationDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedOccupation,
      onChanged: (value) {
        setState(() {
          _selectedOccupation = value;
        });
      },
      items: _occupations.map((occupation) {
        return DropdownMenuItem<String>(
          value: occupation,
          child: Text(occupation),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGenre,
      onChanged: (value) {
        setState(() {
          _selectedGenre = value;
        });
      },
      items: _genderMap.keys.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }
}
