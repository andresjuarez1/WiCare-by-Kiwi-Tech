import 'package:flutter/material.dart';

class FooterComponent extends StatelessWidget {
  final VoidCallback onPressed;

  const FooterComponent({Key? key, required this.onPressed}) : super(key: key);

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
              Expanded(
                child: Text(
                  'WiCare es una app hecho por “KiwiTech” para la comunidad. Ayúdanos a seguir innovando y uniendo a las personas a través de la tecnología',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              '¡Invítanos un kiwi!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
