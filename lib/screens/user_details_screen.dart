import 'package:flutter/material.dart'; // Import for building UI components
import 'package:form/models/user.dart'; // Import for User data model

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.user});

  final User user;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreen();
}


class _UserDetailsScreen extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.user.prenom} ${widget.user.nom}'),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
