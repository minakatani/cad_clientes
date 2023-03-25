import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cad_clientes/models/cliente.dart';

class AddCliente extends StatefulWidget {
  AddCliente({
    super.key,
  });

  @override
  State<AddCliente> createState() => _AddClienteState();

  CollectionReference clientes =
      FirebaseFirestore.instance.collection('clientes');
}

class _AddClienteState extends State<AddCliente> {
  @override
  Widget build(BuildContext context) {
    final nomecompleto = TextEditingController();
    final telefone = TextEditingController();
    final email = TextEditingController();

    Map<String, dynamic> toMap() {
      return {
        'nomecompleto': nomecompleto,
        'telefone': telefone,
        'email': email,
      };
    }

    addCliente() {
      var cliente;
      return cliente
          .add({
            'nomecompleto': nomecompleto,
            'telefone': telefone,
            'email': email
          })
          .then((value) => print("Cliente cadastrado com sucesso"))
          .catchError((error) => print("Falha ao cadastrar o cliente: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de pessoas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomecompleto,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: telefone,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: addCliente,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
