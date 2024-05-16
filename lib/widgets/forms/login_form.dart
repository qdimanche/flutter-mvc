import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form/utils/auth_validator.dart';
import 'package:provider/provider.dart';

import '../../api/user.dart';
import '../../utils/secure_storage.dart';
import '../UI/text_input.dart';
import '../../providers/auth_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final credentials = await secureStorage.readCredentials();
    setState(() {
      _emailController.text = credentials['email'] ?? '';
      _passwordController.text = credentials['password'] ?? '';
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await loginUser(_emailController.text, _passwordController.text);

      final responseData = json.decode(response.body);
      final userMap = responseData['user'];

      print(userMap['id']);

      await secureStorage.saveCredentials(
          _emailController.text,
          _passwordController.text,
          userMap['firstName'] ?? '',
          userMap['lastName'] ?? '',
          userMap['id'] ?? '');
      await secureStorage.saveToken(responseData['token']);

      Provider.of<AuthProvider>(context, listen: false).login();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentification réussie')),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Echec de l\'authentification $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextInput(
              controller: _emailController,
              labelText: 'Email',
              validator: validateEmail,
            ),
            const SizedBox(height: 10),
            TextInput(
              labelText: 'Mot de passe',
              controller: _passwordController,
              obscureText: true,
              validator: validatePassword,
            ),
            const SizedBox(height: 20.0),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _login();
                      }
                    },
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
