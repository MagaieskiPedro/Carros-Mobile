import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class deleteCarro extends StatefulWidget {
  const deleteCarro({super.key});

  @override
  State<deleteCarro> createState() => _deleteCarroState();
}

class _deleteCarroState extends State<deleteCarro> {
  List<dynamic>? valores;

  @override
  void initState() {
    super.initState();
    getValues();
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

  //Funcao que deleta por id
  Future<void> deleteValue(String id) async {
    await FirebaseFirestore.instance.collection("carros").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Deletar Registros"),
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
                        "Marca, Modelo e Ano: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "${item["marca"]},${item["modelo"]} e ${item["ano"]}",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          deleteValue(item.id);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
