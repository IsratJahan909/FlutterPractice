import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper.dart';
import '../model/user.dart';

class UserForm extends StatefulWidget {
  final User? user;
  const UserForm({super.key, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final dobCtrl = TextEditingController();

  String gender = 'Male';
  String? country; // New field
  bool isActive = true;
  String dob = '';
  File? _image;

  // Short list of countries (you can make it longer or use a package)
  final List<String> countries = [
    'Bangladesh',
    'India',
    'Pakistan',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'Brazil',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameCtrl.text = widget.user!.name;
      emailCtrl.text = widget.user!.email;
      ageCtrl.text = widget.user!.age.toString();
      gender = widget.user!.gender;
      dob = widget.user!.dob;
      dobCtrl.text = dob;
      isActive = widget.user!.isActive;
      country = widget.user!.country; // Assuming you add country to User model

      if (widget.user!.imagePath != null) {
        _image = File(widget.user!.imagePath!);
      }
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    ageCtrl.dispose();
    dobCtrl.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob.isNotEmpty ? DateTime.parse(dob) : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dob = picked.toIso8601String().split('T')[0];
        dobCtrl.text = dob;
      });
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    final user = User(
      id: widget.user?.id,
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      age: int.tryParse(ageCtrl.text.trim()) ?? 0,
      gender: gender,
      dob: dob,
      isActive: isActive,
      country: country ?? '', // New field
      imagePath: _image?.path,
    );

    final db = DatabaseHelper();
    if (widget.user == null) {
      await db.insertUser(user);
    } else {
      await db.updateUser(user);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Picker
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        )
                            : null,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Name
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!v.contains('@') || !v.contains('.')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Age
              TextFormField(
                controller: ageCtrl,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Age is required';
                  if (int.tryParse(v) == null || int.parse(v) < 1) return 'Invalid age';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date of Birth
              TextFormField(
                controller: dobCtrl,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.event),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: pickDate,
                  ),
                ),
                validator: (v) => (v?.isEmpty ?? true) ? 'Please select DOB' : null,
              ),
              const SizedBox(height: 16),

              // Gender - Radio Buttons
              const Text(
                'Gender',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Male', 'Female', 'Other'].map((g) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: g,
                        groupValue: gender,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => gender = value);
                          }
                        },
                      ),
                      Text(g),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Country Dropdown
              DropdownButtonFormField<String>(
                value: country,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                items: countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() => country = value);
                },
                validator: (v) => v == null ? 'Please select a country' : null,
              ),
              const SizedBox(height: 16),

              // Active Switch
              SwitchListTile(
                value: isActive,
                title: const Text('User is Active'),
                subtitle: const Text('Enable/disable user account'),
                secondary: const Icon(Icons.verified_user),
                onChanged: (v) => setState(() => isActive = v),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('SAVE USER', style: TextStyle(fontSize: 16)),
                  onPressed: saveUser,
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