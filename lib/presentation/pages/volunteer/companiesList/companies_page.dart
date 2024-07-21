import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/user_remote_data_source.dart';
import 'package:locura1/data/models/company_list.dart';
import 'package:http/http.dart' as http;


class CompaniesPage extends StatefulWidget {
  @override
  _CompaniesPageState createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  late UserRemoteDataSource userRemoteDataSource;
  List<CompanyRankingModel> companies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userRemoteDataSource = UserRemoteDataSource(http.Client());
    _fetchCompanies();
  }

  Future<void> _fetchCompanies() async {
    try {
      List<CompanyRankingModel> fetchedCompanies =
          await userRemoteDataSource.getCompanyRankings();
      setState(() {
        companies = fetchedCompanies;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching companies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 9.0, horizontal: 16.0),
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
                              child: Image.network(
                                companies[index].company.profilePicture,
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
                                  companies[index].company.name,
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
