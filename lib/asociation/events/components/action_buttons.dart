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
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Ver voluntarios',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmar'),
                  content: Text('¿Estás seguro de que deseas borrar esta publicación?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Añadir la lógica para borrar la publicación
                        print("Publicación borrada");
                        Navigator.of(context).pop();
                      },
                      child: Text('Borrar'),
                    ),
                  ],
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 153, 52, 52)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Borrar publicación',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
