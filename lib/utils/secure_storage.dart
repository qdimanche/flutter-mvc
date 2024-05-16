import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';
  static const _keyToken = 'token';
  static const _keyId = 'id';


  Future<void> saveCredentials(String email, String password, String firstName, String lastName, int id) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyFirstName, value: firstName);
    await _storage.write(key: _keyLastName, value: lastName);
    await _storage.write(key: _keyPassword, value: password);
    await _storage.write(key: _keyId, value: id.toString());
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<Map<String, String?>> readCredentials() async {
    String? email = await _storage.read(key: _keyEmail);
    String? firstName = await _storage.read(key: _keyFirstName);
    String? lastName = await _storage.read(key: _keyLastName);
    String? password = await _storage.read(key: _keyPassword);
    String? id = await _storage.read(key: _keyId);
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'id': id
    };
  }

  Future<String?> readToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<void> deleteCredentials() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyFirstName);
    await _storage.delete(key: _keyLastName);
    await _storage.delete(key: _keyPassword);
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyId);
  }
}
