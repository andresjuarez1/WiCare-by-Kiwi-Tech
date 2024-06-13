import 'package:flutter/material.dart';
import '../../volunteersPage/volunteers_page.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VolunteerListPage(
                  volunteers: [], 
                  navigateToVolunteerDetails: (context, title) {
                  },
                ),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF2E8139)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(80, 55)),
          ),
          child: const Text(
            'Ver voluntarios',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmar'),
                  content: const Text('¿Estás seguro de que deseas borrar esta publicación?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Añadir la lógica para borrar la publicación
                        print("Publicación borrada");
                        Navigator.of(context).pop();
                      },
                      child: const Text('Borrar'),
                    ),
                  ],
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 153, 52, 52)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(80, 55)),
          ),
          child: const Text(
            'Borrar publicación',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
