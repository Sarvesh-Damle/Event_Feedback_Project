import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/home_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/feedback_list_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/feedback_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Feedback App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/feedback': (context) => FeedbackScreen(),
        '/feedbackList': (context) => FeedbackListScreen(),
        '/auth': (context) => AuthScreen(),
        '/feedbackDetails': (context) => FeedbackDetailsScreen(),
      },
    );
  }
}
