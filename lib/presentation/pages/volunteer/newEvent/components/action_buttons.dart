import 'package:flutter/material.dart';
import '../dialogs/confirm_dialog.dart';
import '../dialogs/donative_dialog.dart';


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
            'Me Apunto',
            style: TextStyle(color: Colors.white, fontFamily: 'PoppinsRegular'),
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DonationDialog();
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(70, 45)),
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
