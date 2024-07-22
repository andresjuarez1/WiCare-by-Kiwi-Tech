import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/user_remote_data_source.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'package:http/http.dart' as http;

class DonationDialog extends StatelessWidget {
  final EventUnique event;

  DonationDialog({required this.event});

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Nombre del propietario: ${event.association!.bank!.name}'),
          const SizedBox(height: 10),
          Text('Número de cuenta: ${event.association!.bank!.number}'),
          const SizedBox(height: 10),
          Text('Banco: ${event.association!.bank!.bank}'),
          const SizedBox(height: 10),
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
          onPressed: () async {
            try {
              final dataSource = UserRemoteDataSource(http.Client());
              await dataSource.donateToAssociation(event.association!.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Donación realizada con éxito')),
              );
            } catch (e) {
              // Muestra un mensaje de error si la solicitud falla
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al realizar la donación: $e')),
              );
            }
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
