import 'package:flutter/material.dart';
import '../../models/user.dart';

// Define a custom Form widget.
class AddUserForm extends StatefulWidget {
  final ValueChanged<User> userIsAddedCallback; // Callback function to notify the parent widget when a user is added

  const AddUserForm({super.key, required this.userIsAddedCallback});

  @override
  AddUserFormState createState() => AddUserFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>(); // Key to validate the form
  final _nomController = TextEditingController(); // Controller for the nom text field
  final _prenomController = TextEditingController(); // Controller for the prenom text field

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomController,
            decoration: const InputDecoration(labelText: 'Nom'), // Label for the nom text field
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom'; // Validation error message
              }
              return null;
            },
          ),
          TextFormField(
            controller: _prenomController,
            decoration: const InputDecoration(labelText: 'Prénom'), // Label for the prenom text field
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un prénom'; // Validation error message
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) { // Validate the form
                User user = User(_nomController.text, _prenomController.text); // Create a new User object
                widget.userIsAddedCallback(user); // Call the callback function to notify the parent widget
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child: const Text('Ajouter'), // Label for the add button
          ),
        ],
      ),
    );
  }
}
