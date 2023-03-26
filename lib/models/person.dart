import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String name;
  final String phone;
  final String email;

  Person({required this.name, required this.phone, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  factory Person.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Person(
      name: data['name'],
      phone: data['phone'],
      email: data['email'],
    );
  }
}
