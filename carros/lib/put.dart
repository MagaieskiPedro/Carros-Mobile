import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class putCarro extends StatefulWidget {
  const putCarro({super.key});

  @override
  State<putCarro> createState() => _putCarroState();
}

class _putCarroState extends State<putCarro> {
  Map<String, TextEditingController> marcaControllers = {};
  Map<String, TextEditingController> modeloControllers = {};
  Map<String, TextEditingController> anoControllers = {};
  List<dynamic>? values;

  @override
  void initState() {
    super.initState();
    getValues();
  }

  void getValues() {
    FirebaseFirestore.instance.collection("carros").snapshots().listen((
      snapshots,
    ) {
      final data = snapshots.docs; // variavel que armazena os documentos do db
      setState(() {
        values = data;
        for (dynamic doc in data) {
          marcaControllers[doc.id] = TextEditingController();
        }
        for (dynamic doc in data) {
          modeloControllers[doc.id] = TextEditingController();
        }
        for (dynamic doc in data) {
          anoControllers[doc.id] = TextEditingController();
        }
      });
    });
  }

  Future<void> putValueMarca(String id) async {
    FirebaseFirestore.instance.collection("carros").doc(id).set({
      "marca": marcaControllers[id]!.text,
    }, SetOptions(merge: true)); // se não houver dado ele cria
  }

  Future<void> putValueModelo(String id) async {
    FirebaseFirestore.instance.collection("carros").doc(id).set({
      "modelo": modeloControllers[id]!.text,
    }, SetOptions(merge: true)); // se não houver dado ele cria
  }

  Future<void> putValueAno(String id) async {
    FirebaseFirestore.instance.collection("carros").doc(id).set({
      "ano": anoControllers[id]!.text,
    }, SetOptions(merge: true)); // se não houver dado ele cria
  }

  @override
  void dispose() {
    for (dynamic value in marcaControllers.values) {
      value.dispose();
    }
    for (dynamic value in modeloControllers.values) {
      value.dispose();
    }
    for (dynamic value in anoControllers.values) {
      value.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Atualizar Registros"),
        ),
        body: values == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: values!.length,
                itemBuilder: (context, index) {
                  final item = values![index];
                  return ListTile(
                    title: Card(
                      color: Colors.deepPurple,
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Text(
                            "Marca: ${item["marca"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: marcaControllers[item.id],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              putValueMarca(item.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .deepOrangeAccent, // Sets the background color
                              foregroundColor:
                                  Colors.white, // Sets the text and icon color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text("Atualizar marca"),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Modelo: ${item["modelo"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: modeloControllers[item.id],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              putValueModelo(item.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .deepOrangeAccent, // Sets the background color
                              foregroundColor:
                                  Colors.white, // Sets the text and icon color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text("Atualizar Modelo"),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Ano: ${item["ano"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: anoControllers[item.id],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              putValueAno(item.id);
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .deepOrangeAccent, // Sets the background color
                              foregroundColor:
                                  Colors.white, // Sets the text and icon color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text("Atualizar ano"),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
