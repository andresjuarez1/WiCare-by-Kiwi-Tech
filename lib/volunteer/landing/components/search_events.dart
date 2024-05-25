import 'package:flutter/material.dart';

class SearchEvents extends StatelessWidget {
  final Function(String) onChanged;

  SearchEvents({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Buscar eventos',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
