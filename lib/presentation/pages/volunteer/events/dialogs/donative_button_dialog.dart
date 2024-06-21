import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  ConfirmationDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'PoppinsRegular'),
      contentTextStyle: const TextStyle(
          fontSize: 16, color: Colors.black, fontFamily: 'PoppinsRegular'),
      title: Text("Confirmación"),
      content: Text("¿Seguro que quieres mandar ayuda?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'PoppinsRegular'),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text(
            'Sí',
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontFamily: 'PoppinsRegular'),
          ),
        ),
      ],
    );
  }
}
