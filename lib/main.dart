import 'package:diet_recomm/firebase_options.dart';
import 'package:diet_recomm/screens/auth.dart';
import 'package:diet_recomm/screens/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';

void main()  async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MaterialApp(
    home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
              if(snapshot.hasData)
              {
                return const UserPreferences();
              }

              return const AuthScreen();
    },),
  ));
}

