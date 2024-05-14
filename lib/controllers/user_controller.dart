import 'package:flutter/cupertino.dart';
import 'package:form/models/user.dart';

class UserController extends ChangeNotifier{
  final List<User> _users = [];

  List<User> get users => _users;

  Future<void> loadUsers() async {
    _users.add(User('Dupont', 'Jean'));
    _users.add(User('Durand', 'Pierre'));
    _users.add(User('Martin', 'Paul'));
  }

  void addUser(User user) {
    _users.add(user);
  }

  void removeUser(User user){
    _users.remove(user);
  }
}
