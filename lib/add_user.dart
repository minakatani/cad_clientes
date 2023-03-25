import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCliente extends StatefulWidget {
  const AddCliente({super.key});

  @override
  State<AddCliente> createState() => _AddClienteState();
}

class _AddClienteState extends State<AddCliente> {
  TextEditingController? _nomecompleto;
  TextEditingController? _telefone;
  TextEditingController? _email;

//  AddCliente(this._nomecompleto, this._telefone, this._email,);
  CollectionReference clientes =
      FirebaseFirestore.instance.collection('clientes');

  Future<void> addCliente() {
    return clientes
        .add({
          'nomecompleto': _nomecompleto,
          'telefone': _telefone,
          'email': _email
        })
        .then((value) => print("Cliente cadastrado com sucesso"))
        .catchError((error) => print("Falha ao cadastrar o cliente: $error"));
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _nomecompleto,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _telefone,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _email,
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
