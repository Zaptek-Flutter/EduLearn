import 'package:edulearn/application/screens/home.dart';
import 'package:edulearn/authentication/route/authroute.dart';
import 'package:edulearn/authentication/screens/signin.dart';
import 'package:edulearn/authentication/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

void main() async {
  // Ensure widgets are properly initialized before using asynchronous code
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: "assets/.env");

  // Initialize Logger
  var logger = Logger();

  // Initialize Firebase with options from the .env file
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['API_KEY']!,
        appId: dotenv.env['APP_ID']!,
        messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['PROJECT_ID']!,
      ),
    );
    logger.i("Firebase initialized successfully");
  } catch (e) {
    logger.e("Error initializing Firebase: $e");
  }

  runApp(const ProviderScope(child: EduLearn()));
}

class EduLearn extends StatelessWidget {
  const EduLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduLearn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(15, 12, 128, 1)),
        useMaterial3: true,
      ),
      // Set the initial route
      initialRoute: '/auth',
      
      // Define all routes
      routes: {
        '/auth': (context) => const AuthRoute(),
        '/signup': (context) => const Signup(),
        '/home': (context) => const Home(),
        '/login': (context) => const Signin(),
      },
    );
  }
}
