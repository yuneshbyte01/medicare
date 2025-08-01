import 'package:flutter/material.dart';
import 'package:mobile/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedGender = '';
  DateTime? _selectedDob;
  String _error = '';
  String _success = '';

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDob = picked);
    }
  }

  bool _validateInputs() {
    if (_usernameController.text.trim().isEmpty) {
      setState(() => _error = 'Username is required');
      return false;
    }
    if (_nameController.text.trim().isEmpty) {
      setState(() => _error = 'Full name is required');
      return false;
    }
    if (_emailController.text.trim().isEmpty) {
      setState(() => _error = 'Email is required');
      return false;
    }
    if (!_emailController.text.contains('@')) {
      setState(() => _error = 'Enter a valid email');
      return false;
    }
    if (_passwordController.text.length < 8) {
      setState(() => _error = 'Password must be at least 8 characters');
      return false;
    }
    if (_phoneController.text.trim().isEmpty) {
      setState(() => _error = 'Phone number is required');
      return false;
    }
    if (_selectedGender.isEmpty) {
      setState(() => _error = 'Please select a gender');
      return false;
    }
    if (_selectedDob == null) {
      setState(() => _error = 'Please select your date of birth');
      return false;
    }
    setState(() => _error = '');
    return true;
  }

  void _register() async {
    if (!_validateInputs()) return;

    setState(() {
      _success = '';
      _error = '';
    });

    final user = {
      'username': _usernameController.text.trim(),
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
      'phoneNumber': _phoneController.text.trim(),
      'gender': _selectedGender,
      'dob': _selectedDob!.toIso8601String().substring(0, 10), // yyyy-MM-dd
      'role': 'PATIENT',
    };

    final result = await AuthService.registerUser(user);

    if (result['success']) {
      setState(() => _success = 'Registration successful! Redirecting to login...');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); // Return to login screen
      });
    } else {
      setState(() => _error = result['message'] ?? 'Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register for MediTrack')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: _selectedGender.isEmpty ? null : _selectedGender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value ?? '';
                });
              },
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDob == null
                        ? 'Select Date of Birth'
                        : 'DOB: ${_selectedDob!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Pick Date'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),

            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(_error, style: const TextStyle(color: Colors.red)),
              ),

            if (_success.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(_success, style: const TextStyle(color: Colors.green)),
              ),
          ],
        ),
      ),
    );
  }
}
