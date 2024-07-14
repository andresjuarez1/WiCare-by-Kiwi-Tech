import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../data/datasources/remote/event_remote_data_source.dart';
import '../../../../data/repositories/event_repository_impl.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/use_cases/create_event.dart';

class PostEvent extends StatefulWidget {
  @override
  _PostEventState createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final _formKey = GlobalKey<FormState>(); // Llave para el formulario
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

  void _createEvent() async {
    print('Botón "Crear evento" presionado');
    if (_formKey.currentState?.validate() ?? false) {
      print('Formulario válido');
      final event = Event(
        name: _eventNameController.text,
        description: _descriptionController.text,
        hour: _selectedStartTime != null
            ? '${_selectedStartTime!.hour}:${_selectedStartTime!.minute} - ${_selectedEndTime!.hour}:${_selectedEndTime!.minute}'
            : '',
        date: _selectedDate.toString().substring(0, 10),
        cathegory: _selectedCategories ?? '',
        location: _location.text,
      );
      try {
        final String? token = await _getToken();
        if (token == null) {
          print('Token no disponible');
          return;
        }
        final remoteDataSource = EventRemoteDataSource(http.Client(), token);
        final repository = EventRepositoryImpl(remoteDataSource);
        final createEventUseCase = CreateEventUseCase(repository);
        await createEventUseCase.execute(event);
        print('Evento creado');
      } catch (error) {
        print('Error al crear evento: $error');
      }
    } else {
      print('Formulario inválido');
    }
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
            key: _formKey, // Asignar la llave al formulario
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
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre del evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF5CA666)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF5CA666)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        labelStyle: const TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFF5CA666)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFF5CA666)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedDate.toString().substring(0, 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecciona una fecha';
                        }
                        DateTime inputDate;
                        try {
                          inputDate = DateTime.parse(value);
                        } catch (e) {
                          return 'Formato de fecha inválido';
                        }
                        DateTime currentDate = DateTime.now();
                        if (inputDate.isBefore(currentDate)) {
                          return 'La fecha no puede ser anterior a la fecha actual';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Hora de inicio',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFF5CA666)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFF5CA666)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedStartTime != null
                            ? _selectedStartTime!.format(context)
                            : '',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecciona una hora de inicio';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Hora de fin',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFF5CA666)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFF5CA666)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedEndTime != null
                            ? _selectedEndTime!.format(context)
                            : '',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecciona una hora de fin';
                        }
                        if (_selectedStartTime != null &&
                            _selectedEndTime != null) {
                          if (_selectedEndTime!.hour <
                              _selectedStartTime!.hour ||
                              (_selectedEndTime!.hour ==
                                  _selectedStartTime!.hour &&
                                  _selectedEndTime!.minute <
                                      _selectedStartTime!.minute)) {
                            return 'La hora de fin no puede ser anterior a la hora de inicio';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<String>(
                  value: _selectedCategories,
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategories = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    labelStyle: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF5CA666)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF5CA666)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona una categoría';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _location,
                  decoration: InputDecoration(
                    labelText: 'Ubicación',
                    labelStyle: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF5CA666)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF5CA666)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la ubicación';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Imagen del evento',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF5CA666)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: _image != null
                            ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                            : const Center(
                          child: Text(
                            'Selecciona una imagen',
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _createEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5CA666),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Crear evento',
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
