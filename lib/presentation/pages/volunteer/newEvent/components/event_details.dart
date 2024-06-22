import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Descripción',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel pretium libero. Donec sit amet lacus sit amet orci tristique eleifend sed in velit. Sed a lobortis ipsum, non finibus justo. Donec ac gravida justo. ',
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w200,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
