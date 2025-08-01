import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _error = '';
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final result = await AuthService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
      await prefs.setString('role', result['role']);

      switch (result['role']) {
        case 'ADMIN':
          Navigator.pushReplacementNamed(context, '/adminDashboard');
          break;
        case 'DOCTOR':
          Navigator.pushReplacementNamed(context, '/doctorDashboard');
          break;
        case 'PATIENT':
          Navigator.pushReplacementNamed(context, '/patientDashboard');
          break;
        default:
          setState(() => _error = 'Unknown user role');
      }
    } else {
      setState(() => _error = result['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to MediTrack')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text("Don't have an account? Register here"),
            ),
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
