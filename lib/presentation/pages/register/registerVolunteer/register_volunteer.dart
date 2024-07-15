import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/entities/volunteer.dart';
import '../../../../domain/use_cases/register_volunteer_user.dart';
import '../../login/login_page.dart';
import 'map/select_location_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterVolunteerPage extends StatefulWidget {
  @override
  _RegisterVolunteerPageState createState() => _RegisterVolunteerPageState();
}

class _RegisterVolunteerPageState extends State<RegisterVolunteerPage> {
  double? _latitude;
  double? _longitude;

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
          backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
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

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _curpController = TextEditingController();
  final _cellphoneController = TextEditingController();
  final _postalController = TextEditingController();
  // final _addressController = TextEditingController();
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
  String? _selectedGenre;
  bool _termsAccepted = false;

  void _registerVolunteer() async {
    print('Botón "Crear Cuenta" presionado');
    if (_formKey.currentState?.validate() ?? false) {
      print('Formulario válido');
      final volunteer = Volunteer(
        name: _nameController.text,
        age: _ageController.text,
        curp: _curpController.text,
        cellphone: _cellphoneController.text,
        postal: _postalController.text,
        latitude: _latitudeController.text,
        longitude: _longitudeController.text,
        // address: _addressController.text,
        occupation: _selectedOccupation ?? '',
        genre: _selectedGenre ?? '',
        email: _emailController.text,
        password: _passwordController.text,
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildLabel('Nombre completo'),
                      const SizedBox(height: 5.0),
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
                          }
                          int? age = int.tryParse(value);
                          if (age == null) {
                            return 'Por favor, ingresa un número válido';
                          }
                          if (age <= 15 || age >= 70) {
                            return 'La edad debe estar entre 15 y 70 años';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20.0),
                      _buildAddressButton(),
                      // if (_latitude != null && _longitude != null)
                        // Text('Latitud: $_latitude, Longitud: $_longitude'),
                      const SizedBox(height: 20.0),

                      _buildLabel('CURP'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Teléfono'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Código Postal'),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 10.0),
                      _buildLabel('Ocupación'),
                      const SizedBox(height: 5.0),
                      _buildOccupationDropdown(),
                      const SizedBox(height: 10.0),
                      _buildLabel('Género'),
                      const SizedBox(height: 5.0),
                      _buildGenderDropdown(),
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
                          bool isValidEmail =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value);
                          if (!isValidEmail) {
                            return 'Ingresa un correo electrónico válido';
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
                          if (value.length < 8) {
                            return 'La contraseña debe tener al menos 8 caracteres';
                          }
                          bool isValidPassword = RegExp(
                                  r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).+$')
                              .hasMatch(value);
                          if (!isValidPassword) {
                            return 'La contraseña debe contener al menos:\n Una letra en mayúscula\n Un dígito \n Un carácter especial';
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
                      const SizedBox(height: 40.0),
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
      enableSuggestions: false,
      autocorrect: false,
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
