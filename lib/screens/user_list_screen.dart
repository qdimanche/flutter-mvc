import 'package:flutter/material.dart'; // Import for building UI components
import 'package:form/models/user.dart'; // Import for User data model
import 'package:form/controllers/user_controller.dart'; // Import for User management
import 'package:form/screens/user_details_screen.dart';
import 'package:form/widgets/forms/add_user_form.dart';
import 'package:form/widgets/layout/myscaffold.dart'; // Import for Add User form widget

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key}); // StatefulWidget for state management

  @override
  State<StatefulWidget> createState() => _UserListScreen(); // Create state object
}

class _UserListScreen extends State<UserListScreen> {
  final UserController _userController =
  UserController(); // User controller instance

  Widget _buildUserList() {
    // Builds a ListView displaying user information
    return ListView.builder(
      itemCount: _userController.users.length, // Get user count from controller
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index]; // Get user data at index
        return ListTile(
          onTap: () {
            // Rediriger l'utilisateur vers la vue de détails de l'utilisateur
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user)),
            );
          },
          title: Text(
            '${user.prenom} ${user.nom}', // Display user's first and last name
            style: const TextStyle(
              color: Colors.black, // Set text color to black
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _userController.removeUser(user);
              setState(() {});
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _userController
        .loadUsers(); // Load initial user data on screen initialization
  }

  Future<void> userAddDialog() async {
    // Function to display a dialog for adding a new user
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add User'), // Dialog title
        content: AddUserForm(
          userIsAddedCallback: (User user) {
            // Callback for adding a user
            _userController.addUser(user); // Add user to controller
            setState(() {}); // Trigger UI rebuild to reflect changes
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      name: 'User list',
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30.0), // Container margin
          width: 400, // Container width
          child: Column(
            children: [
              Expanded(child: _buildUserList()), // Display user list widget
              ElevatedButton(
                // Elevated button to open add user dialog
                onPressed: userAddDialog,
                child: const Text("Add user"), // Button text
              )
            ],
          ),
        ),
      ),
    );
  }
}
