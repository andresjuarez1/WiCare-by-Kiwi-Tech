import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:locura1/domain/use_cases/register_association_user.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/entities/association.dart';
import '../../login/login_page.dart';

class RegisterAssociationPage extends StatefulWidget {
  @override
  _RegisterAssociationPageState createState() => _RegisterAssociationPageState();
}

class _RegisterAssociationPageState extends State<RegisterAssociationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCompanyController = TextEditingController();
  final _addressCompanyController = TextEditingController();
  final _foundationDateController = TextEditingController();

  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _rfcController = TextEditingController();

  final _socialReasons = [
    'Casa hogar',
    'Asilo de ancianos',
    'Refugio de animales',
    'Protección del medio ambiente',
    'Salud'
  ];
  
  String? _selectSocialReasons;
  final _nameManagerController = TextEditingController();
  final _positionManagerController = TextEditingController();
  final _phoneManagerController = TextEditingController();
  final _addressManagerController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();
  final Map<String, String> _genderMap = {
    'Masculino': 'm',
    'Femenino': 'f',
    'No binario': 'nb',
    'Prefiero no decir': 'Prefiero no decir',
  };
  String? _selectedGenre;

  bool _termsAccepted = false;

  void _registerVolunteer() async {
    print('Botón "Crear Cuenta" presionado');
    if (_formKey.currentState?.validate() ?? false) {
      print('Formulario válido');
      final association = Association(
        name: _nameCompanyController.text,
        address: _addressCompanyController.text,
        foundation_date: _foundationDateController.text,

        social_reason: _selectSocialReasons ?? '',
        description: _descriptionController.text,
        cellphone: _phoneController.text,
        RFC: _rfcController.text,
        name_manager: _nameManagerController.text,
        position: _positionManagerController.text,
        cellphone_manager: _phoneManagerController.text,
        address_manager: _addressManagerController.text,
        email: _emailController.text,
        password: _passwordController.text,
        age: _ageController.text,
        genre: _selectedGenre ?? '',
      );

      try {
        print('Intentando registrar voluntario: ${association.email}');
        final remoteDataSource = UserRemoteDataSource(http.Client());
        final repository = UserRepositoryImpl(remoteDataSource);
        final registerVolunteerUseCase = RegisterAssociationUseCase(repository);
        await registerVolunteerUseCase.execute(association);

        print('Usuario registrado correctamente: ${association.email}');
        _showSuccessDialog();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (error) {
        print('Error al registrar usuario: $error');
        _showErrorDialog(error.toString());
      }
    }
    else {
      print('Error al registrar usuario: no entra avalidar el form ');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registro Exitoso'),
          content: Text('Tu cuenta de asociación ha sido creada exitosamente.'),
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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
                        '¡Bienvenido, asociacion!',
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
                      _buildLabel('Fecha  de fundación'),
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
                      _buildLabel('Descripción General'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Ingresa una descripción general',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa una descripción general';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Teléfono de la asociación'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Ingresa el teléfono de la asociación',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el teléfono de la asociación';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('RFC'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _rfcController,
                        label: 'Ingresa el RFC de la asociación',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el RFC de la asociación';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Razón Social'),
                      SizedBox(height: 5.0),
                      _buildSocialReasonDropdown(),
                      Text(
                        'Datos del Encargado',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Nombre'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _nameManagerController,
                        label: 'Ingresa el nombre del encargado',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre';
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
                      _buildLabel('Género'),
                      SizedBox(height: 5.0),
                      _buildGenderDropdown(),
                      _buildLabel('Puesto'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _positionManagerController,
                        label: 'Ingresa el puesto del encargado',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el puesto';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Teléfono'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _phoneManagerController,
                        label: 'Ingresa el teléfono del encargado',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el teléfono';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildLabel('Domicilio'),
                      SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _addressManagerController,
                        label: 'Ingresa el domicilio del encargado',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el domicilio';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
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
                      SizedBox(height: 40.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _registerVolunteer,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF2E8139)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding:
                            MaterialStateProperty.all<EdgeInsetsGeometry>(
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
                'assets/progress-bar-volunteer3.png',
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
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2E8139)),
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

  Widget _buildSocialReasonDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectSocialReasons,
      onChanged: (value) {
        setState(() {
          _selectSocialReasons = value;
        });
      },
      items: _socialReasons.map((socialReason) {
        return DropdownMenuItem<String>(
          value: socialReason,
          child: Text(socialReason),
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
