import 'dart:convert'; // Asegúrate de agregar esta importación
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/entities/volunteer.dart';
import '../../../../domain/use_cases/register_volunteer_user.dart';
import '../../login/login_page.dart';
import 'map/select_location_page.dart';

class RegisterVolunteerPage extends StatefulWidget {
  @override
  _RegisterVolunteerPageState createState() => _RegisterVolunteerPageState();
}

class _RegisterVolunteerPageState extends State<RegisterVolunteerPage> {
  double? _latitude;
  double? _longitude;
  List<String> _detectedSkills = []; // Lista para almacenar las habilidades detectadas

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ageController = TextEditingController();
  final _curpController = TextEditingController();
  final _cellphoneController = TextEditingController();
  final _postalController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _occupations = [
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
  String _habilidadesResultado = '';
  String? _selectedGenre;
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  Future<void> _loadSavedLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _latitude = prefs.getDouble('latitude');
      _longitude = prefs.getDouble('longitude');
      _latitudeController.text = _latitude?.toString() ?? '';
      _longitudeController.text = _longitude?.toString() ?? '';
    });
    print('Ubicación cargada: Latitud: $_latitude, Longitud: $_longitude');
  }

  void _navigateToSelectLocationPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationPage()),
    );
    if (result != null && result is bool && result) {
      _loadSavedLocation();
    }
  }

  Widget _buildAddressButton() {
    return _buildStyledButton('Seleccionar Ubicación en el Mapa');
  }

  Widget _buildStyledButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _navigateToSelectLocationPage,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
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
          text,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Future<void> _detectarHabilidades() async {
    final response = await http.post(

      Uri.parse('${dotenv.env['APIURL']}/analyzer/habilidades'),  // Cambia localhost a 192.168.100.191
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'texto': _descriptionController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {

        _habilidadesResultado = '${data['habilidades']}';
        print(_habilidadesResultado);

      });
    } else {
      setState(() {
        _habilidadesResultado = 'Error al detectar habilidades';
      });
    }
  }

  void _registerVolunteer2() async {
    print('Botón "Crear Cuenta" presionado');
    if (_formKey.currentState?.validate() ?? false) {
      print('Formulario válido');
      final volunteer = Volunteer(
        name: _nameController.text,
        description: _descriptionController.text,
        age: _ageController.text,
        curp: _curpController.text,
        cellphone: _cellphoneController.text,
        postal: _postalController.text,
        latitude: _latitudeController.text,
        longitude: _longitudeController.text,
        occupation: _selectedOccupation ?? '',
        genre: _selectedGenre ?? '',
        email: _emailController.text,
        password: _passwordController.text,
      );
      print(_descriptionController);
      try {
        print('Intentando registrar voluntario: ${volunteer.email}');
        final remoteDataSource = UserRemoteDataSource(http.Client());
        final repository = UserRepositoryImpl(remoteDataSource);
        final registerVolunteerUseCase = RegisterVolunteerUseCase(repository);
        await registerVolunteerUseCase.execute(volunteer);
        print('Usuario registrado correctamente: ${volunteer.email}');
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
      print('Error al registrar usuario: no entra a validar el form ');
    }
  }
  void _registerVolunteer() async {
    print('Botón "Crear Cuenta" presionado');

    if (_formKey.currentState?.validate() ?? false) {
      print('Formulario válido');

      // Primero, realiza el análisis de habilidades
      await _detectarHabilidades();

      // Actualiza el campo de descripción con las habilidades detectadas
      _descriptionController.text = _habilidadesResultado;

      // Imprime las habilidades obtenidas en la consola
      print('Habilidades detectadas: ${_habilidadesResultado}');

      final volunteer = Volunteer(
        name: _nameController.text,
        description: _descriptionController.text,
        age: _ageController.text,
        curp: _curpController.text,
        cellphone: _cellphoneController.text,
        postal: _postalController.text,
        latitude: _latitudeController.text,
        longitude: _longitudeController.text,
        occupation: _selectedOccupation ?? '',
        genre: _selectedGenre ?? '',
        email: _emailController.text,
        password: _passwordController.text,
      );

      print(_descriptionController.text);  // Imprime el contenido actualizado del controlador de descripción

      try {
        print('Intentando registrar voluntario: ${volunteer.email}');
        final remoteDataSource = UserRemoteDataSource(http.Client());
        final repository = UserRepositoryImpl(remoteDataSource);
        final registerVolunteerUseCase = RegisterVolunteerUseCase(repository);
        await registerVolunteerUseCase.execute(volunteer);
        print('Usuario registrado correctamente: ${volunteer.email}');
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
      print('Error al registrar usuario: no entra a validar el form ');
    }
  }


  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text(
              'Tu cuenta de voluntario ha sido creada exitosamente.'),
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

  void _showSkillsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Habilidades Detectadas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var skill in _detectedSkills)
                Text(skill),
            ],
          ),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
                      Image.asset(
                        'assets/wicare-logo-inicio.png',
                        width: 180,
                      ),
                      const SizedBox(height: 25.0),
                      const Text(
                        '¡Bienvenido, voluntario!',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFF2E8139),
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Descripción',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa una descripción';
                          }
                          return null;
                        },
                        maxLines: 4,
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: _detectarHabilidades,
                        child: const Text('Detectar Habilidades'),
                      ),
                      const SizedBox(height: 20.0),
                      if (_detectedSkills.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Habilidades Detectadas:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            for (var skill in _detectedSkills)
                              Text(skill),
                          ],
                        ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _ageController,
                        label: 'Edad',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu edad';
                          } else if (int.tryParse(value) == null) {
                            return 'Por favor, ingresa un número válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _curpController,
                        label: 'CURP',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu CURP';
                          } else if (value.length != 18) {
                            return 'La CURP debe tener 18 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _cellphoneController,
                        label: 'Teléfono',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu número de teléfono';
                          } else if (value.length < 10) {
                            return 'El número de teléfono debe tener al menos 10 dígitos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _postalController,
                        label: 'Código Postal',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu código postal';
                          } else if (value.length != 5) {
                            return 'El código postal debe tener 5 dígitos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _latitudeController,
                        label: 'Latitud',
                        readOnly: true,
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _longitudeController,
                        label: 'Longitud',
                        readOnly: true,
                      ),
                      const SizedBox(height: 20.0),
                      _buildOccupationDropdown(),
                      const SizedBox(height: 20.0),
                      _buildGenderDropdown(),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Correo Electrónico',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu correo electrónico';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor, ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Contraseña',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa una contraseña';
                          } else if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirmar Contraseña',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirma tu contraseña';
                          } else if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
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
                          const Expanded(
                            child: Text(
                              'Acepto los términos y condiciones',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF2E8139),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      _buildStyledButton('Crear Cuenta'),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
    );
  }

  Widget _buildOccupationDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedOccupation,
      decoration: const InputDecoration(
        labelText: 'Ocupación',
        border: OutlineInputBorder(),
      ),
      items: _occupations.map((occupation) {
        return DropdownMenuItem<String>(
          value: occupation,
          child: Text(occupation),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedOccupation = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecciona tu ocupación';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGenre,
      decoration: const InputDecoration(
        labelText: 'Género',
        border: OutlineInputBorder(),
      ),
      items: _genderMap.keys.map((gender) {
        return DropdownMenuItem<String>(
          value: _genderMap[gender],
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGenre = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecciona tu género';
        }
        return null;
      },
    );
  }
}
