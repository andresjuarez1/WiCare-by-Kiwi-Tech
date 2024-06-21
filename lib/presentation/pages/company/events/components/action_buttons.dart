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
                  },
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: WidgetStateProperty.all<Size>(Size(70, 45)),
          ),
          child: const Text(
            'Donar',
            style: TextStyle(color: Colors.white, fontFamily: 'PoppinsRegular'),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
