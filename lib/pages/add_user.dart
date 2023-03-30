import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cad_clientes/models/person.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class PersonAddScreen extends StatefulWidget {
  @override
  _PersonAddScreenState createState() => _PersonAddScreenState();
}

class _PersonAddScreenState extends State<PersonAddScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateofbirdhController = TextEditingController();
  final _cpfController = TextEditingController();
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
    _dateofbirdhController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _addCliente() {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final dateofbirdh = _dateofbirdhController.text;
    final cpf = _cpfController.text;
    final email = _emailController.text;
    final person = Person(
        name: name,
        phone: phone,
        dateofbirdh: dateofbirdh,
        cpf: cpf,
        email: email);
    _peopleRef.add(person.toMap());
    _nameController.clear();
    _phoneController.clear();
    _dateofbirdhController.clear();
    _cpfController.clear();
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
              Text("Insira os dados para cadastro."),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome Completo',
                ),
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                controller: _phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Telefone'),
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                controller: _dateofbirdhController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data de Nascimento'),
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                controller: _cpfController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'CPF'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
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
