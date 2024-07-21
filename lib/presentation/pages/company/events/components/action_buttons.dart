import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import '../dialogs/donative_button_dialog.dart';

class ActionButtons extends StatelessWidget {
  final EventUnique event;

  ActionButtons({required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DonationDialog(event: event);
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
