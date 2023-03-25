import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cad_clientes/databases/db_firestore.dart';
import 'package:cad_clientes/models/cliente.dart';
import 'package:flutter/material.dart';

class ClientesRepository extends ChangeNotifier {
  final List<Cliente> _lista = [];
  late FirebaseFirestore db;
//  late AuthService auth;
  MoedaRepository moedas;

  ClientesRepository({required this.auth, required this.moedas}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritas() async {
    if (auth.usuario != null && _lista.isEmpty) {
      try {
        final snapshot = await db
            .collection('usuarios/${auth.usuario!.uid}/favoritas')
            .get();

        for (var doc in snapshot.docs) {
          Cliente cliente = cliente.tabela.firstWhere(
              (clientes) => clientes.nomecompleto == doc.get('nomecompleto'));
          _lista.add(clientes);
          notifyListeners();
        }
      } catch (e) {
        debugPrint('Sem id de usuário');
      }
    }
  }

  UnmodifiableListView<Clientes> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moeda> moedas) async {
    for (var moeda in moedas) {
      if (!_lista.any((atual) => atual.sigla == moeda.sigla)) {
        _lista.add(moeda);
        try {
          await db
              .collection('usuarios/${auth.usuario!.uid}/favoritas')
              .doc(moeda.sigla)
              .set({
            'moeda': moeda.nome,
            'sigla': moeda.sigla,
            'preco': moeda.preco,
          });
        } on FirebaseException catch (e) {
          debugPrint('Permissão Required no Firestore: $e');
        }
      }
    }
    notifyListeners();
  }

  remove(Moeda moeda) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/favoritas')
        .doc(moeda.sigla)
        .delete();
    _lista.remove(moeda);
    notifyListeners();
  }
}
