import 'package:flutter/material.dart';
import 'package:form/widgets/UI/text_input.dart';
import 'package:form/utils/auth_validator.dart';

import '../../api/user.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        print(
            "${_firstNameController.text}, ${_lastNameController
                .text},${_emailController.text},${_passwordController.text} ");

        int result = await registerUser(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text,
            _passwordController.text,
            ["user"]);
        Navigator.of(context).pop();

        if (result == 201) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('Inscription réussie'),
                  content: Text(
                      'Bonjour, ${_firstNameController.text} ${_lastNameController.text}!'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () =>
                      {
                        Navigator.of(context).pop(),
                        Navigator.of(context).pushReplacementNamed('/')
                      },
                    ),
                  ],
                ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('Échec de l\'inscription'),
                  content: Text(
                      'Une erreur est survenue: ${result
                          .toString()}. Veuillez réessayer.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Erreur'),
                content: Text('Erreur lors de l\'inscription: $e'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      }
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
              labelText: 'Nom',
              controller: _lastNameController,
              validator: validateName,
            ),
            const SizedBox(height: 10),
            TextInput(
              labelText: 'Prénom',
              controller: _firstNameController,
              validator: validateName,
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            TextInput(
              labelText: 'Confirmez le mot de passe',
              controller: _confirmPasswordController,
              obscureText: true,
              validator: (value) => confirmPasswordValidator(value, _passwordController.text),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Accepter les termes et conditions'),
              value: _agreeToTerms,
              onChanged: (bool? newValue) {
                setState(() {
                  _agreeToTerms = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agreeToTerms ? _submitForm : null,
              child: const Center(child: Text('S\'inscrire')),
            ),
          ],
        ),
      ),
    );
  }
}