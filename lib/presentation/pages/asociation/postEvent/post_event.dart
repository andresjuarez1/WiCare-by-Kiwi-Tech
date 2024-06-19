import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostEvent extends StatefulWidget {
  @override
  _PostEventState createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
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
            'Crear Anuncio',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              TextFormField(
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
              ),
              const SizedBox(height: 25),
              TextFormField(
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
                      text: selectedDate.toString().substring(0, 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Categoría',
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
                items: const [
                  DropdownMenuItem(
                    value: 'Categoria1',
                    child: Text(
                      'Categoria 1',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Categoria2',
                    child: Text(
                      'Categoria 2',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Categoria3',
                    child: Text(
                      'Categoria 3',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 25),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: _selectImage,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Color(0xFF5CA666)),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 13.0),
                      ),
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
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Color(0xFF5CA666)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 13.0),
                      ),
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
    );
  }
}
