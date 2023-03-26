import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cad_clientes/models/person.dart';

class PersonListScreen extends StatefulWidget {
  @override
  _PersonListScreenState createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  late final CollectionReference _peopleRef;
  late final Stream<QuerySnapshot> _peopleStream;

  @override
  void initState() {
    super.initState();
    _peopleRef = FirebaseFirestore.instance.collection('people');
    _peopleStream = _peopleRef.snapshots();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _addCliente() {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final person = Person(name: name, phone: phone, email: email);
    _peopleRef.add(person.toMap());
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
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
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addCliente,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
