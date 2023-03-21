import 'package:cad_clientes/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

  class ClientesRepository extends ChangeNotifier {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();


  List<Clientes> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  ClientesRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readClientes();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readClientes() {};

  }
