import 'package:flutter/material.dart';
import 'package:form/api/message.dart';
import 'package:form/controllers/message_controller.dart';

import '../models/message_model.dart';
import '../utils/secure_storage.dart';
import '../widgets/layout/myscaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  final SecureStorage secureStorage = SecureStorage();
  final MessageController _messageController = MessageController(); // User co
  Future<List<MessageModel>> _futureMessages = Future.value([]);

  String _userEmail = '';
  String _userFirstName = '';
  String _userLastName = '';
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _loadCredentials().then((value) {
      setState(() {
        _userEmail = value['email']!;
        _userFirstName = value['firstName']!;
        _userLastName = value['lastName']!;
        _userId = value['id']!;
        _futureMessages = Message().fetchMessagesByUser(_userId);
      });
    });
  }

  Future<Map<String, String>> _loadCredentials() async {
    final credentials = await secureStorage.readCredentials();
    return {
      'email': credentials['email'] ?? '',
      'firstName': credentials['firstName'] ?? '',
      'lastName': credentials['lastName'] ?? '',
      'id': credentials['id'] ?? ''
    };
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      name: 'Profile',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("email: $_userEmail"),
            Text("firstName : $_userFirstName"),
            Text("lastName : $_userLastName"),
            const Text(""),
            const Text("Messages :"),
            FutureBuilder<List<MessageModel>>(
                future: _futureMessages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Aucun message trouvé.'));
                  } else {
                    List<MessageModel> messages = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          MessageModel message = messages[index];
                          return ListTile(
                            title: Text(message.subject),
                            subtitle: Text(message.body),
                            onTap: () {},
                          );
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}
