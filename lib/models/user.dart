import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  String _nom;
  String _prenom;

  User(this._nom, this._prenom);

  String get nom => _nom;

  String get prenom => _prenom;

  set nom(String value) {
    if (value.isNotEmpty) {
      _nom = value;
    }
  }

  set prenom(String value) {
    if (value.isNotEmpty) {
      _prenom = value;
    }
  }
}
