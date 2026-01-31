import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const LargeFormPage(),
    );
  }
}

class LargeFormPage extends StatefulWidget {
  const LargeFormPage({super.key});

  @override
  State<LargeFormPage> createState() => _LargeFormPageState();
}

class _LargeFormPageState extends State<LargeFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _password;
  String? _gender;
  bool _subscribe = false;
  String? _country;
  bool _switchValue = false;
  DateTime? _dob;

  final List<String> countries = ["Bangladesh", "India", "USA", "UK"];
  final List<String> genderOptions = ["Male", "Female", "Other"];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
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
      print("Country: $_country");
      print("Subscribe: $_subscribe");
      print("Switch: $_switchValue");
      print("DOB: $_dob");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form Submitted Successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Large Form Example"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Please enter your name" : null,
                onSaved: (value) => _name = value?.trim(),
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Please enter your email" : null,
                onSaved: (value) => _email = value?.trim(),
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter your password" : null,
                onSaved: (value) => _password = value,
              ),
              const SizedBox(height: 16),

              // Gender
              const Text(
                "Gender",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genderOptions.map((label) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: label,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text(label),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Country Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Country",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                value: _country,
                items: countries
                    .map(
                      (country) => DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _country = value;
                  });
                },
                validator: (value) =>
                value == null ? "Please select your country" : null,
              ),
              const SizedBox(height: 16),

              // Subscribe Checkbox
              CheckboxListTile(
                title: const Text("Subscribe to newsletter"),
                value: _subscribe,
                onChanged: (value) {
                  setState(() {
                    _subscribe = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 8),

              // Notifications Switch
              SwitchListTile(
                title: const Text("Enable Notifications"),
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
                secondary: const Icon(Icons.notifications),
              ),
              const SizedBox(height: 16),

              // Date of Birth
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  _dob == null
                      ? "Select Date of Birth"
                      : "DOB: ${_dob!.day}/${_dob!.month}/${_dob!.year}",
                ),
                trailing: ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text("Pick Date"),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text("Submit", style: TextStyle(fontSize: 18)),
                  onPressed: _submit,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}