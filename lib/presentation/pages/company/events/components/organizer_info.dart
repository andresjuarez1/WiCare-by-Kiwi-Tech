import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';

class OrganizerInfo extends StatelessWidget {
  final EventUnique event;

  OrganizerInfo({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Información del encargsado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            event.association!.name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              fontFamily: 'PoppinsRegular',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  width: 75,
                  height: 75,
                  event.association!.profilePicture,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Text(
                    event.association!.description,
                    style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 13,
                      fontWeight: FontWeight.w200,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
