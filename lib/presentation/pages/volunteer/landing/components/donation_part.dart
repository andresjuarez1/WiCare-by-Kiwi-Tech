import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterComponent extends StatelessWidget {
  const FooterComponent({Key? key}) : super(key: key);

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
              _launchURL('https://buymeacoffee.com/wicare');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
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

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Aquí puedes manejar el error de manera adecuada, como mostrar un mensaje al usuario
    }
  }
}
