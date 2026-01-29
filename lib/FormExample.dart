import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* =======================
   ROOT APP
======================= */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LargeFormPage(),
    );
  }
}

class LargeFormPage extends StatelessWidget {
  const LargeFormPage({super.key});

  @override
  State<LargeFormPage> createState() => _LargeFormPageState();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _LargeFormPageState  extends State<LargeFormPage>{

  final _formKey = GlobalKey<FormState>();

  String _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _password;
  String? _gender;
  bool? _subscribe = false;
  String? _country;
  bool? _switchValue = false;
  DateTime? _dob;


  List<String> countries = ["Bangladesh" , "India", "USA", "UK"];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
         lastDate: DateTime.now(),
        );

    if (picked != null) {
      setState(() {
        _dob = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Name: $_name");
      print("Email: $_email");
      print("Password: $_password");
      print("Gender: $_gender");
      print("Subscribe: $_subscribe");
      print("Country: $_country");
      print("VAlUE: $_switchValue");
      print("Date of Birth: $_dob");


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        body: Form(
            child: Form
        )

      ),
    )
  }

}