import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookProvider with ChangeNotifier {
  bookEvent({required userId, required eventId}) async {
    try {
      //http://localhost:5019/book
      //192.168.17.191

      final response = await http.post(
        Uri.parse('http://192.168.17.191:5024/book'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'eventId': eventId,
        }),
      );

      final extractedRes = await json.decode(response.body);
      debugPrint('result from api ${extractedRes['result']}');
      if (response.statusCode != 200) {
        throw HttpException(extractedRes['message']);
      }

      //_bookedEvent = Event.fromJson(extractedRes['result']);
      // _bookedEvent = json.decode(extractedRes["result"]);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
