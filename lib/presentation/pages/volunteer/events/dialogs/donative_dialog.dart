import 'package:flutter/material.dart';

class DonationDialog extends StatelessWidget {
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
        fontFamily: 'PoppinsRegular',
      ),
      contentTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: 'PoppinsRegular',
      ),
      title: const Text("Datos Bancarios"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Folio: 192039123"),
          SizedBox(height: 10),
          Text("Nombre de asociación: Nombre asociación"),
          SizedBox(height: 10),
          Text("Banco: Banco Ejemplo"),
          SizedBox(height: 10),
          Text("Número de cuenta: 1234567890"),
          SizedBox(height: 10),
          Text("Fecha: 27/06/2024"),
          SizedBox(height: 10),
        ],
      ),
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
              fontFamily: 'PoppinsRegular',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
          ),
          child: const Text(
            'Confirmar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'PoppinsRegular',
            ),
          ),
        ),
      ],
    );
  }
}
