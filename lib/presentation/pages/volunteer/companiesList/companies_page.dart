import 'package:flutter/material.dart';

class CompaniesPage extends StatelessWidget {
  final List<Map<String, String>> companies = [
    {'name': 'Empresa 1', 'image': 'assets/bbva.jpg'},
    {'name': 'Empresa 2', 'image': 'assets/bbva.jpg'},
    {'name': 'Empresa 3', 'image': 'assets/bbva.jpg'},
    {'name': 'Empresa 4', 'image': 'assets/bbva.jpg'},
    {'name': 'Empresa 5', 'image': 'assets/bbva.jpg'},
    {'name': 'Empresa 7', 'image': 'assets/bbva.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Top de empresas',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w600,
            color: Color(0xFF5CA666),
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.separated(
          itemCount: companies.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color.fromARGB(255, 200, 200, 200),
            thickness: 1,
            height: 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                title: Row(
                  children: [
                    Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          companies[index]['image']!,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companies[index]['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PoppinsRegular',
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
