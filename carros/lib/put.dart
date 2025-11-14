import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class putCarro extends StatefulWidget {
  const putCarro({super.key});

  @override
  State<putCarro> createState() => _putCarroState();
}

class _putCarroState extends State<putCarro> {
  Map<String, TextEditingController> controllers = {};
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
      for (dynamic doc in data) {
        controllers[doc.id] = TextEditingController();
      }
    });
  }

  Future<void> putValue(String id) async {
    FirebaseFirestore.instance.collection("carros").doc(id).set({
      "marca": controllers[id]!.text,
      "modelo": controllers[id]!.text,
      "ano": controllers[id]!.text,
    }, SetOptions(merge: true)); // se não houver dado ele cria
  }

  @override
  void dispose() {
    for (dynamic value in controllers.values) {
      value.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("PUT")),
        body: values == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: values!.length,
                itemBuilder: (context, index) {
                  final item = values![index];
                  return ListTile(
                    title: Text(
                      "Marca: ${item["marca"]}, Modelo: ${item["modelo"]}, Ano: ${item["ano"]}",
                    ),
                    subtitle: Column(
                      children: [
                        TextField(
                          controller: controllers[item.id],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            putValue(item.id);
                          },
                          child: Text("AlterarDado"),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
