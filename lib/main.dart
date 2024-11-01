import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'screens/create_account_screen.dart'; // Import the Create Account screen
import 'screens/report_emergency_screen.dart'; // Import your generated screens here
import 'screens/emergency_reported_screen.dart'; // Import the Emergency Reported screen
import 'screens/emergency_status_screen.dart'; // Import the Emergency Status screen
import 'screens/sign_in_screen.dart'; // Import the Sign In screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widget binding
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Response App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Set the initial route to the Create Account screen
      routes: {
        '/': (context) => const CreateAccountScreen(), // Route to CreateAccountScreen
        '/report': (context) => const ReportEmergencyScreen(), // Route to the ReportEmergencyScreen
        '/emergencyReported': (context) => EmergencyReportedScreen(), // Route to Emergency Reported screen
        '/signIn': (context) => const SignInScreen(), // Route to Sign In screen
      },
      onGenerateRoute: (settings) {
        // Handle dynamic route for emergency status screen
        if (settings.name == '/emergencyStatus') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return EmergencyStatusScreen(
                incidentType: args['incidentType'],
                reportedTime: args['reportedTime'],
              );
            },
          );
        }
        return null;
      },
    );
  }
}

// The rest of your existing MyHomePage code can remain as is
