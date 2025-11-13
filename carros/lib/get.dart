import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getCarros extends StatefulWidget {
  const getCarros({super.key});

  @override
  State<getCarros> createState() => _getCarrosState();
}

class _getCarrosState extends State<getCarros> {
  String? marca;
  String? modelo;
  String? ano;

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() {
    FirebaseFirestore.instance.collection("carros").snapshots().listen((
      snapshots,
    ) {
      final data = snapshots.docs.first.data();

      setState(() {
        marca = data["marca"];
        modelo = data["modelo"];
        ano = data["ano"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("GET Carros")),
        body: Center(
          child: Column(
            children: [
              Text("Marca: "),
              Text("$marca"),
              Text("Modelo: "),
              Text("$modelo"),
              Text("Ano: "),
              Text("$ano"),
            ],
          ),
        ),
      ),
    );
  }
}
