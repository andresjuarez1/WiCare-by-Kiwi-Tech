import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../data/datasources/remote/event_remote_data_source.dart';
import '../../../../data/repositories/event_repository_impl.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/use_cases/create_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostEvent extends StatefulWidget {
  @override
  _PostEventState createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final _formKey = GlobalKey<FormState>(); // Llave para el formulario
  final _eventNameController = TextEditingController();
  final _location = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categories = ['Ambiental', 'Social', 'Educativa', 'Sanitaria', 'Cultural', 'Animales'];
  String? _selectedCategories;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
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
        hour: _selectedTime != null ? '${_selectedTime!.hour}:${_selectedTime!.minute}' : '',
        date: _selectedDate.toString().substring(0, 10),
        cathegory: _selectedCategories ?? '',
        location:_location.text,
      );
      try {
        // Aquí puedes enviar el evento a donde sea necesario
        print('Creando evento:');
        final String? token = await _getToken();
        if (token == null) {
          print('Token no disponible');
          return;
        }
        final remoteDataSource = EventRemoteDataSource(http.Client(), token);
        final repository = EventRepositoryImpl(remoteDataSource);
        final createEventUseCase = CreateEventUseCase(repository);
        await createEventUseCase.execute(event);
        print('evento creado');
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Aquí puedes procesar la imagen seleccionada
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
            'Crear Evento XD',
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
                SizedBox(height: 15),
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
                    contentPadding: EdgeInsets.symmetric(
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
                SizedBox(height: 25),
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
                      borderSide: BorderSide(color: Color(0xFF5CA666)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFF5CA666)),
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
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF5CA666)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF5CA666)),
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
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Hora',
                        labelStyle: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF5CA666)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF5CA666)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedTime != null
                            ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                            : '',
                      ),
                      validator: (value) {
                        if (_selectedTime == null) {
                          return 'Por favor selecciona una hora';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
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
                      borderSide: BorderSide(color: greenColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: greenColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la ubicación del evento';
                    }
                    return null;
                  },
                ),
                Text('Categoria'),
                SizedBox(height: 5),
                _buildCategoryDropdown(),
                SizedBox(height: 25),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: _selectImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Color(0xFF5CA666)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                      ),
                      child: const Text(
                        'Seleccionar imagen',
                        style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15.0,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: _createEvent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5CA666),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                      ),
                      child: const Text(
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

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategories,
      onChanged: (value) {
        setState(() {
          _selectedCategories = value;
        });
      },
      items: _categories.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
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
