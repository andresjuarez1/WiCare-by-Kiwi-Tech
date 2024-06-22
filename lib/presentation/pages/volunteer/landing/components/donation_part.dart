import 'package:flutter/material.dart';

import '../dialogs/donatiwi_dialog.dart';

class FooterComponent extends StatelessWidget {
  final VoidCallback onDonateConfirmed;

  const FooterComponent({Key? key, required this.onDonateConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/kiwilogo-inicio.png',
                  width: 90,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'WiCare es una app hecha por “KiwiTech” para la comunidad. Ayúdanos a seguir innovando y uniendo a las personas a través de la tecnología',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DonatiwiDialog();
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
            ),
            child: const Text(
              '¡Invítanos un kiwi!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
