import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../data/datasources/remote/event_remote_data_source.dart';
import '../../../../data/repositories/event_repository_impl.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/use_cases/create_event.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostEvent extends StatefulWidget {
  @override
  _PostEventState createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _location = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categories = [
    'Ambiental',
    'Social',
    'Educativa',
    'Sanitaria',
    'Cultural',
    'Animales'
  ];
  String? _selectedCategories;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> _detectarGroserias(String texto) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['APIURL']}/analyzer/groserias'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'texto': texto,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['contiene_groserias']) {
          // Aquí puedes mostrar un mensaje al usuario
          print('La descripción contiene groserías.');
          return true;
        } else {
          print('Texto corregido: ${data['texto_corregido']}\nNo contiene groserías.');
          return false;
        }
      } else {
        // Manejar error de solicitud
        print('Error al detectar groserías');
        return false;
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return false;
    }
  }

  Future<void> _createEvent() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedStartTime == null || _selectedEndTime == null) {
        _showErrorMessage('Por favor selecciona una hora de inicio y una hora de fin');
        return;
      }

      if (_image == null) {
        _showErrorMessage('No se ha seleccionado una imagen');
        return;
      }

      final contieneGroserias = await _detectarGroserias(_descriptionController.text);
      if (contieneGroserias) {
        _showErrorMessage('La descripción contiene groserías. No se puede crear el evento.');
        return;
      }

      final event = Event(
        name: _eventNameController.text,
        description: _descriptionController.text,
        hour_start: '${_selectedStartTime!.hour}:${_selectedStartTime!.minute}',
        hour_end: '${_selectedEndTime!.hour}:${_selectedEndTime!.minute}',
        date: '${_selectedDate.toIso8601String().split('T').first}', // Formato yyyy-MM-dd
        cathegory: _selectedCategories ?? '',
        picture: '',
      );

      try {
        final String? token = await _getToken();
        if (token == null) {
          _showErrorMessage('Token no disponible');
          return;
        }

        setState(() {
          _isLoading = true;
        });

        final remoteDataSource = EventRemoteDataSource(http.Client(), token);
        final repository = EventRepositoryImpl(remoteDataSource);
        final createEventUseCase = CreateEventUseCase(repository);

        await createEventUseCase.execute(event, _image!);
        _showSuccessMessage('Evento creado exitosamente');
      } catch (error) {
        _showErrorMessage('Error al crear evento: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showErrorMessage('Formulario inválido');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = pickedTime;
        } else {
          _selectedEndTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = const Color(0xFF2E8139);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Text(
            'Crear Evento',
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5CA666),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                TextFormField(
                  controller: _eventNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del evento',
                    labelStyle: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Descripción del evento',
                    labelStyle: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(text: _selectedDate.toLocal().toString().split(' ')[0]),
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: greenColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: greenColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione una fecha';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(text: _selectedStartTime?.format(context) ?? 'Hora de inicio'),
                      decoration: InputDecoration(
                        labelText: 'Hora de inicio',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: greenColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: greenColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione una hora de inicio';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(text: _selectedEndTime?.format(context) ?? 'Hora de fin'),
                      decoration: InputDecoration(
                        labelText: 'Hora de fin',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: greenColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: greenColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione una hora de fin';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: _selectedCategories,
                  hint: const Text('Categoría'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategories = newValue;
                    });
                  },
                  items: _categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: greenColor),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: _image == null
                        ? Center(child: Text('Seleccionar imagen'))
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createEvent,
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text('Crear Evento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5CA666),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
