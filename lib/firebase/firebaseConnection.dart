import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class connection extends StatefulWidget {
  @override
  _connectionState createState() => _connectionState();
}

class _connectionState extends State<connection> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Something went wrong');
          return null;
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('Connection is succesfuly');
          return null;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return null;
      },
    );
  }
}
