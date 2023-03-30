import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cad_clientes/models/person.dart';

Future<List> getPeople() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('people').get();
  return querySnapshot.docs.map((doc) => Person.fromSnapshot(doc)).toList();
}

final List<String> items = List<String>.generate(10000, (i) => '$i');

class PersonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pessoas Cadastradas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('people').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final people = snapshot.data!.docs
              .map((doc) => Person.fromSnapshot(doc))
              .toList();

          return ListView.builder(
            itemCount: people.length,
            itemBuilder: (context, index) {
              final person = people[index];
              return ListTile(
                title: Text("Nome: ${person.name}"),
                subtitle:
                    Text("Telefone: ${person.phone} | email: ${person.email}"),
                trailing: Text("DN: ${person.dateofbirdh}"),
              );
            },
          );
        },
      ),
    );
  }
}
