import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//esta es una prueba no le hagan caso
class PruebaDeTextosPage extends StatefulWidget {
  @override
  _PruebaDeTextosPageState createState() => _PruebaDeTextosPageState();
}

class _PruebaDeTextosPageState extends State<PruebaDeTextosPage> {
  final TextEditingController _habilidadesController = TextEditingController();
  final TextEditingController _groseriasController = TextEditingController();
  String _habilidadesResultado = '';
  String _groseriasResultado = '';

  Future<void> _detectarHabilidades() async {
    final response = await http.post(

      Uri.parse('${dotenv.env['APIURL']}/analyzer/habilidades'),  // Cambia localhost a 192.168.100.191
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'texto': _habilidadesController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {

        _habilidadesResultado = 'Habilidades: ${data['habilidades']}';

      });
    } else {
      setState(() {
        _habilidadesResultado = 'Error al detectar habilidades';
      });
    }
  }

  Future<void> _detectarGroserias() async {
    final response = await http.post(
      Uri.parse('http://192.168.100.191:5000/groserias'),  // Cambia localhost a 192.168.100.191
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'texto': _groseriasController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        if (data['contiene_groserias']) {
          _groseriasResultado = 'No puedes realizar esta descripción.';
        } else {
          _groseriasResultado = 'Texto corregido: ${data['texto_corregido']}\nNo contiene groserías.';
        }
      });
    } else {
      setState(() {
        _groseriasResultado = 'Error al detectar groserías';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba de Textos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _habilidadesController,
              decoration: InputDecoration(labelText: 'Texto para habilidades'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _detectarHabilidades,
              child: Text('Detectar Habilidades'),
            ),
            SizedBox(height: 16),
            Text(_habilidadesResultado),
            Divider(),
            TextField(
              controller: _groseriasController,
              decoration: InputDecoration(labelText: 'Texto para groserías'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _detectarGroserias,
              child: Text('Detectar Groserías'),
            ),
            SizedBox(height: 16),
            Text(_groseriasResultado),
          ],
        ),
      ),
    );
  }
}
