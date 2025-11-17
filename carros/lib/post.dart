import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class postCarro extends StatefulWidget {
  const postCarro({super.key});

  @override
  State<postCarro> createState() => _postCarroState();
}

class _postCarroState extends State<postCarro> {
  //Logica
  TextEditingController novaMarca = TextEditingController();
  TextEditingController novoModelo = TextEditingController();
  TextEditingController novoAno = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String? erro;

  Future<void> postValue() async {
    try {
      FirebaseFirestore.instance.collection("carros").add({
        // JSON
        "marca": novaMarca.text,
        "modelo": novoModelo.text,
        "ano": novoAno.text,
      });
    } catch (err) {
      // se houver erro, recebe mensagem
      setState(() {
        erro = "Erro ao enviar dados";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Publicar um registro"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Container(
                width: 1850,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple,
                ),
                child: Column(
                  children: [
                    Text(
                      "Insira uma marca",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: novaMarca,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Insira um modelo: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: novoModelo,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Insira um ano: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: novoAno,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: postValue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .deepOrangeAccent, // Sets the background color
                        foregroundColor:
                            Colors.white, // Sets the text and icon color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text("Publicar"),
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
