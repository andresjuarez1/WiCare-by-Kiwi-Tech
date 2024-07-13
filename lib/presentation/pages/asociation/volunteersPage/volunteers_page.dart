import 'package:flutter/material.dart';

class VolunteerListPage extends StatelessWidget {
  final List<Map<String, String>> volunteers;
  final Function(BuildContext, String) navigateToVolunteerDetails;

  VolunteerListPage(
      {required this.volunteers, required this.navigateToVolunteerDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Lista de Voluntarios',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w600,
            color: Color(0xFF5CA666),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: volunteers.length,
              itemBuilder: (context, index) {
                final volunteer = volunteers[index];
                return InkWell(
                  onTap: () =>
                      navigateToVolunteerDetails(context, volunteer['title']!),
                  child: VolunteerItem(
                    name: volunteer['title']!,
                    image: volunteer['image']!,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class VolunteerItem extends StatelessWidget {
  final String name;
  final String image;

  VolunteerItem({
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
