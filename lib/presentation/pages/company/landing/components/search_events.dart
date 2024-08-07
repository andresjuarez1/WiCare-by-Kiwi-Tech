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
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          labelStyle: const TextStyle(
            color: Color(0xFFA3A3A3),
            fontFamily: 'PoppinsRegular',
            fontSize: 14.0,
            fontWeight: FontWeight.w100
          ),
        ),
        style: const TextStyle(
          fontFamily: 'PoppinsRegular',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
