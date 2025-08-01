import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';  // <- import RegisterScreen
import 'screens/admin_dashboard.dart';
import 'screens/doctor_dashboard.dart';
import 'screens/patient_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: Check if user is already logged in
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('role');

  runApp(MediTrackApp(initialRoute: getInitialRoute(role)));
}

String getInitialRoute(String? role) {
  switch (role) {
    case 'ADMIN':
      return '/adminDashboard';
    case 'DOCTOR':
      return '/doctorDashboard';
    case 'PATIENT':
      return '/patientDashboard';
    default:
      return '/';
  }
}

class MediTrackApp extends StatelessWidget {
  final String initialRoute;
  const MediTrackApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTrack',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/adminDashboard': (context) => const AdminDashboardScreen(),
        '/doctorDashboard': (context) => const DoctorDashboardScreen(),
        '/patientDashboard': (context) => const PatientDashboardScreen(),
      },
    );
  }
}
