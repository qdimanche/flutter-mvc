import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class MessageController extends ChangeNotifier {
  final List<MessageModel> _messages = [];

  List<MessageModel> get messages => _messages;

  List<MessageModel> getUserMessages(String userId) {
    List<MessageModel> userMessages = _messages.where((message) => message.userId == userId).toList();
    return userMessages.isEmpty ? [] : userMessages;
  }
}