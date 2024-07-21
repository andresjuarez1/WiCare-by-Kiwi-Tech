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

  void _createEvent() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedStartTime == null || _selectedEndTime == null) {
        print('Por favor selecciona una hora de inicio y una hora de fin');
        return;
      }

      if (_image == null) {
        print('No se ha seleccionado una imagen');
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
      // Imprimir los campos en la consola
      print('Nombre del evento: ${_eventNameController.text}');
      print('Descripción: ${_descriptionController.text}');
      print('Hora de inicio: ${_selectedStartTime!.format(context)}');
      print('Hora de fin: ${_selectedEndTime!.format(context)}');
      print('Fecha: ${_selectedDate.toIso8601String().split('T').first}');
      print('Categoría: ${_selectedCategories ?? ''}');
      print('Imagen seleccionada: ${_image!.path}');

      try {
        final String? token = await _getToken();
        if (token == null) {
          print('Token no disponible');
          return;
        }

        setState(() {
          _isLoading = true;
        });

        // Crear una instancia del repositorio y el caso de uso
        final remoteDataSource = EventRemoteDataSource(http.Client(), token);
        final repository = EventRepositoryImpl(remoteDataSource);
        final createEventUseCase = CreateEventUseCase(repository);

        // Ejecutar el caso de uso para crear el evento
        await createEventUseCase.execute(event, _image!);
        print('Evento creado exitosamente');
      } catch (error) {
        print('Error al crear evento: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
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
                        text: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecciona una fecha';
                        }
                        // Aquí puedes validar la fecha si es necesario, pero sin convertirla
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
                        text: _selectedEndTime != null
                            ? _selectedEndTime!.format(context)
                            : '',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecciona una hora de fin';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<String>(
                  value: _selectedCategories,
                  items: _categories
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona una categoría';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
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
                        : Center(
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
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: _createEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CA666),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Crear evento',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
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
