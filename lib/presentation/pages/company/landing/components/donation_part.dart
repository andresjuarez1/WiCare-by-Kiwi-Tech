import 'package:flutter/material.dart';

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
                  return AlertDialog(
                    title: const Text(
                      'Donatiwi',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    content: const Text(
                      'Kiwitech es una empresa orgullosamente chiapaneca que trabaja para innovar día con día',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Color(0xFFBB3737)),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onDonateConfirmed();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Color(0xFF2E8139)),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('Donatiwi'),
                      ),
                    ],
                  );
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
