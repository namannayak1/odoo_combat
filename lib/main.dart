import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_recomm/firebase_options.dart';
import 'package:diet_recomm/screens/auth.dart';
import 'package:diet_recomm/screens/tabs.dart'; // Assuming this is the new screen you want to navigate to
import 'package:diet_recomm/screens/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: Start()));
}

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return FutureBuilder<bool>(
            future: checkUserDocumentExists(snapshot.data!.uid),
            builder: (context, docSnapshot) {
              if (docSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (docSnapshot.hasData) {
                if (docSnapshot.data!) {
                  return const Tabs(); // Navigate to TabsScreen if document exists
                } else {
                  return const UserPreferences(); // Navigate to UserPreferences if document does not exist
                }
              } else if (docSnapshot.hasError) {
                return const Center(child: Text("Error checking user document"));
              } else {
                return const AuthScreen();
              }
            },
          );
        } else {
          return const AuthScreen();
        }
      },
    );
  }

  Future<bool> checkUserDocumentExists(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }
}
