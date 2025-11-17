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
  List<dynamic>? valores;

  @override
  void initState() {
    super.initState();
    getValues();
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

  // Lista itens
  void getValues() {
    FirebaseFirestore.instance.collection("carros").snapshots().listen((
      snapshots,
    ) {
      final data = snapshots.docs;
      setState(() {
        valores = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Listagem de carros: "),
        ),
        body: valores == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: ListView.builder(
                  itemCount: valores!.length,
                  itemBuilder: (context, index) {
                    final item = valores![index];
                    return ListTile(
                      tileColor: Colors.deepPurple,
                      title: Text(
                        "Marca | Modelo | Ano: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "${item["marca"]} | ${item["modelo"]} | ${item["ano"]}",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
