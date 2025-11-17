import 'package:carros/delete.dart';
import 'package:carros/get.dart';
import 'package:carros/login.dart';
import 'package:carros/post.dart';
import 'package:carros/put.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

// inicializar app e conexão
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, //plataforma android das configurações
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Login());
  }
}
