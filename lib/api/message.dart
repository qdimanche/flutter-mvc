import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/message_model.dart';

class Message {
  static const String apiUrl = 'https://s3-5197.nuage-peda.fr/messages';

  Future<List<MessageModel>> fetchMessages() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<MessageModel> messages =
      body.map((dynamic item) => MessageModel.fromJson(item)).toList();
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<MessageModel>> fetchMessagesByUser(String userId) async {
    final response = await http.get(Uri.parse("$apiUrl?userId=$userId"));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<MessageModel> messages =
      body.map((dynamic item) => MessageModel.fromJson(item)).toList();
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}