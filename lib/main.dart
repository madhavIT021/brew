 import 'package:brew/models/user.dart';
import 'package:brew/screens/wrapper.dart';
import 'package:brew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

void main() async{

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDntfEpe1ciZfy5ou679hrX73d8AuLXEbw",
        appId: "1:952805310416:android:9eaf17e9a4f276cd4fc3d5",
        messagingSenderId: "952805310416",
        projectId: "md-brew-crew-3a97e",
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: Authservice().user,
      initialData: null,
      child: const MaterialApp(

        debugShowCheckedModeBanner: false,

        home: Wrapper(),
      ),
    );
  }
}


