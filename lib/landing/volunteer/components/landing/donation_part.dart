import 'package:flutter/material.dart';

class FooterComponent extends StatelessWidget {
  final VoidCallback onPressed;

  const FooterComponent({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 25.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'WiCare es un producto hecho por la empresa “KiwiTec” para ayudar a la comunidad. Ayudanos a seguir innovando y acercando a las personas a través de la tecnología',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Done aquí',
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
