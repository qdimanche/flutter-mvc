import 'package:flutter/material.dart';

import '../api/message.dart';
import '../models/message_model.dart';
import '../widgets/layout/myscaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late Future<List<MessageModel>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = Message().fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        name: 'Home',
        body: FutureBuilder<List<MessageModel>>(
            future: futureMessages,
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
            }));
  }
}
