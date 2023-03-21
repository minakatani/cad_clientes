import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Pessoa {
  final String nome;
  final String telefone;
  final String email;

  Pessoa({required this.nome, required this.telefone, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }
}

class CadastroPessoas extends StatefulWidget {
  const CadastroPessoas({super.key});

  @override
  _CadastroPessoasState createState() => _CadastroPessoasState();
}

class _CadastroPessoasState extends State<CadastroPessoas> {
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  late final DatabaseReference _pessoaRef;

  @override
  void initState() {
    super.initState();
    _pessoaRef = FirebaseDatabase.instance.ref('pessoa.db');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    final nome = _nomeController.text;
    final telefone = _telefoneController.text;
    final email = _emailController.text;
    final pessoa = Pessoa(nome: nome, telefone: telefone, email: email);
    _pessoaRef.push().set(pessoa.toMap());
    _nomeController.clear();
    _telefoneController.clear();
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
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _cadastrar,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
