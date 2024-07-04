import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:locura1/domain/use_cases/register_company_user.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/entities/company.dart';
import '../../../../domain/entities/company.dart';
import '../../login/login_page.dart';

class RegisterCompanyPage extends StatefulWidget {
  @override
  _RegisterCompanyPageState createState() =>
      _RegisterCompanyPageState();
}

class _RegisterCompanyPageState extends State<RegisterCompanyPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCompanyController = TextEditingController();
  final _addressCompanyController = TextEditingController();
  final _foundationDateController = TextEditingController();

  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _rfcController = TextEditingController();

  final _context = [
    'Comercio',
    'Servicio',
    'Industrial',
    'Agricultura y Ganaderia',
    'Tecnología',
    'Farmacéutica'
  ];

  String? _selectContext;
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
      final company = Company(
        name: _nameCompanyController.text,
        address: _addressCompanyController.text,
        foundation_date: _foundationDateController.text,
        context: _selectContext ?? '',
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
        print('Intentando registrar voluntario: ${company.email}');
        final remoteDataSource = UserRemoteDataSource(http.Client());
        final repository = UserRepositoryImpl(remoteDataSource);
        final registerVolunteerUseCase = RegisterCompanyUseCase(repository);
        await registerVolunteerUseCase.execute(company);

        print('Usuario registrado correctamente: ${company.email}');
        _showSuccessDialog();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (error) {
        print('Error al registrar usuario: $error');
        _showErrorDialog(error.toString());
      }
    } else {
      print('Error al registrar usuario: no entra avalidar el form ');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text(
              'Tu cuenta de empresa ha sido creada exitosamente.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
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
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
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
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60.0),
                      Image.asset(
                        'assets/wicare-logo-inicio.png',
                        width: 180,
                      ),
                      const SizedBox(height: 25.0),
                      const Text(
                        '¡Bienvenido, empresa!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _buildLabel('Nombre de la Empresa'),
                      const SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _nameCompanyController,
                        label: 'Ingresa el nombre de la empresa',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre de la empresa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('Domicilio'),
                      const SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _addressCompanyController,
                        label: 'Ingresa el domicilio de la empresa',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el domicilio de la empresa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('Fecha  de fundación'),
                      const SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _foundationDateController,
                        label: 'Ingresa la fecha de fundación (AAAA-MM-DD)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa la fecha de fundación de la empresa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('Descripción General'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Teléfono de la empresa'),
                      const SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Ingresa el teléfono de la empresa',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el teléfono de la empresa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('RFC'),
                      const SizedBox(height: 5.0),
                      _buildTextField(
                        controller: _rfcController,
                        label: 'Ingresa el RFC de la empresa',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el RFC de la empresa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('Razón Social'),
                      const SizedBox(height: 5.0),
                      _buildSocialReasonDropdown(),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Datos del Encargado',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('Nombre'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Edad'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Género'),
                      const SizedBox(height: 5.0),
                      _buildGenderDropdown(),
                      _buildLabel('Puesto'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Teléfono'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Domicilio'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 20.0),
                      const Text(
                        'Crea tu cuenta',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E8139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildLabel('Correo Electrónico'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Contraseña'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Confirmar Contraseña'),
                      const SizedBox(height: 5.0),
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
                          const Text(
                            'Acepto los términos y condiciones',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _registerVolunteer,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xFF2E8139)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(vertical: 13.0),
                            ),
                          ),
                          child: const Text(
                            'Crear Cuenta',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
          style: const TextStyle(
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
        labelStyle: const TextStyle(fontSize: 15.0, color: Color(0xFFBCBCBC)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      validator: validator,
    );
  }

  Widget _buildSocialReasonDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectContext,
      onChanged: (value) {
        setState(() {
          _selectContext = value;
        });
      },
      items: _context.map((socialReason) {
        return DropdownMenuItem<String>(
          value: socialReason,
          child: Text(socialReason),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }
}
