import 'package:flutter/material.dart';
import '../dialogs/donative_button_dialog.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  onConfirm: () {
                    print("Ayuda enviada");
                    //TODO: hacer la lógica del envío de ayuda
                  },
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Me Apunto',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Donar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
