import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import '../dialogs/confirm_dialog.dart';
import '../dialogs/donative_dialog.dart';

class ActionButtons extends StatelessWidget {
  final EventUnique event;
  final Future<void> Function(int) onSubscribe; 

  ActionButtons({required this.event, required this.onSubscribe});
  
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
                  onConfirm: () async {
                    try {
                      await onSubscribe(event.id); 
                      print("Suscripción exitosa");
                    } catch (e) {
                      print("Error al suscribirse: $e");
                    }
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
                return DonationDialog(event: event);
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
