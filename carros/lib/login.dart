import 'package:carros/delete.dart';
import 'package:carros/get.dart';
import 'package:carros/main.dart';
import 'package:carros/post.dart';
import 'package:carros/put.dart';
import 'package:flutter/material.dart';

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
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Get",
              backgroundColor: Colors.cyan,
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Post",backgroundColor: Colors.cyan,),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Put",backgroundColor: Colors.cyan,),
            BottomNavigationBarItem(icon: Icon(Icons.delete), label: "Delete",backgroundColor: Colors.cyan,),
          ],
          currentIndex: currentIndex,
          onTap: changeIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  String correctUser = "";
  String correctPass = "";

  String message = "";

  void login() {
    if (user.text == correctUser && pass.text == correctPass) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
      setState(() {
        message = "";
      });
    } else {
      message = "credenciais incorretas";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pagina de login"),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Digite seu usuario",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Digite sua senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        login();
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
