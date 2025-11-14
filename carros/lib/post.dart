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
        "ano": novoAno,
      });
    } catch (err) {
      // se houver erro, recebe mensagem
      setState(() {
        erro = "Erro ao enviar a temperatura";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("PostPage")),
        body: Center(
          child: Column(
            children: [
              Text("Insira uma marca"),
              TextField(controller: novaMarca),
              Text("Insira um modelo: "),
              TextField(controller: novoModelo),
              Text("Insira um ano: "),
              TextField(controller: novoAno),
              ElevatedButton(onPressed: postValue, child: Text("Enviar")),
            ],
          ),
        ),
      ),
    );
  }
}
