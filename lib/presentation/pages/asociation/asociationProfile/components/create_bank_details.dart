import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/user_remote_data_source.dart';
import 'package:locura1/data/repositories/user_repository_impl.dart';
import 'package:locura1/domain/entities/postBankDetails.dart';
import 'package:locura1/domain/use_cases/post_bank_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BankDetailsPage extends StatefulWidget {
  @override
  _BankDetailsPageState createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  late final PostBankDetailsUseCase _postBankDetailsUseCase;
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _routingNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUseCase();
  }

  Future<void> _initializeUseCase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userRemoteDataSource = UserRemoteDataSource(http.Client());
    final userRepository = UserRepositoryImpl(userRemoteDataSource);
    _postBankDetailsUseCase = PostBankDetailsUseCase(userRepository);
  }

  Future<void> _postBankDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');

    if (userId == null || token == null) {
      print('Error: No se encontró userId o token en SharedPreferences');
      return;
    }

    final bankDetails = BankDetails(
      name: _bankNameController.text,
      number: _accountNumberController.text,
      bank: _routingNumberController.text,
    );

    try {
      await _postBankDetailsUseCase.execute(userId, bankDetails, token);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Detalles bancarios enviados exitosamente')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar detalles bancarios: $e')));
      print('Error al enviar detalles bancarios: $e');
    }
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _routingNumberController.dispose();
    super.dispose();
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.green),
        ),
        labelStyle: const TextStyle(fontSize: 15.0, color: Color(0xFFBCBCBC)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      enableSuggestions: false,
      autocorrect: false,
      validator: validator,
    );
  }

  Widget _buildStyledButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF2E8139)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 13.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Datos bancarios',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w600,
            color: Color(0xFF5CA666),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              _buildStyledTextField(
                controller: _bankNameController,
                label: 'Nombre del encargado',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              _buildStyledTextField(
                controller: _accountNumberController,
                label: 'Número de cuenta',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de cuenta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              _buildStyledTextField(
                controller: _routingNumberController,
                label: 'Nombre del banco',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del banco';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildStyledButton(
                'Enviar Detalles Bancarios',
                () {
                  if (_formKey.currentState!.validate()) {
                    _postBankDetails();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
