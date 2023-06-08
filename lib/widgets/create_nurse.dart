import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNurseView extends StatefulWidget {
  const CreateNurseView({Key? key}) : super(key: key);

  @override
  _CreateNurseViewState createState() => _CreateNurseViewState();
}

class _CreateNurseViewState extends State<CreateNurseView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _fullLastNameController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedGender;
  String? _selectedRole;
  DateTime? _selectedBirthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Nurse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                _selectBirthDate(context);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: _selectedBirthDate != null
                      ? TextEditingController(
                          text: DateFormat('dd MMMM yyyy, HH:mm:ss \'UTC-5\'')
                              .format(_selectedBirthDate!))
                      : null,
                  decoration: const InputDecoration(labelText: 'Birth Date'),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _fullLastNameController,
              decoration: const InputDecoration(labelText: 'Full Last Name'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: [
                DropdownMenuItem(
                  value: 'M',
                  child: const Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'F',
                  child: const Text('Female'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a gender';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nationalIdController,
              decoration: const InputDecoration(labelText: 'National ID'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: 'Role'),
              items: [
                DropdownMenuItem(
                  value: 'admin',
                  child: const Text('Admin'),
                ),
                DropdownMenuItem(
                  value: 'user',
                  child: const Text('User'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a role';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createNurse,
              child: const Text('Create Nurse'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthDate = pickedDate;
      });
    }
  }

  void _createNurse() {
    String fullName = _fullNameController.text;
    String fullLastName = _fullLastNameController.text;
    String nationalId = _nationalIdController.text;
    String phone = _phoneController.text;

    if (_selectedBirthDate != null &&
        _selectedGender != null &&
        _selectedRole != null &&
        fullName.isNotEmpty &&
        fullLastName.isNotEmpty &&
        nationalId.isNotEmpty &&
        phone.isNotEmpty) {
      Timestamp birthDateTimestamp = Timestamp.fromDate(_selectedBirthDate!);

      Map<String, dynamic> nurseData = {
        'full_name': fullName,
        'full_last_name': fullLastName,
        'gender': _selectedGender,
        'national_id': nationalId,
        'phone': phone,
        'role': _selectedRole,
        'birth_date': birthDateTimestamp,
      };

      FirebaseFirestore.instance.collection('nurses').add(nurseData);

      _selectedBirthDate = null;
      _fullNameController.clear();
      _fullLastNameController.clear();
      _nationalIdController.clear();
      _phoneController.clear();
      _selectedGender = null;
      _selectedRole = null;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Nurse created successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}
