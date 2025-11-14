import 'package:carros/delete.dart';
import 'package:carros/get.dart';
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

// Navegação
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  void changeIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  List<Widget> screens = [
    getCarros(),
    postCarro(),
    putCarro(),
    deleteCarro(),
  ]; // Metodos que exportam telas

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: screens.elementAt(currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Get"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Post"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Put"),
            BottomNavigationBarItem(icon: Icon(Icons.delete), label: "Delete"),
          ],
          currentIndex: currentIndex,
          onTap: changeIndex,
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavBar());
  }
}
