import 'dart:convert';
import 'dart:io';

import 'package:booking_app/models/event.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book.model.dart';

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => [..._events];

  List<Book> _bookedEvents = [];

  List<Book> get bookedEvents => [..._bookedEvents];
  fetchEvents() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.17.191:5026/event'));

      debugPrint('Events response: ${response.body}');

      final extractedRes = await json.decode(response.body);

      if (response.statusCode != 200) {
        throw Error();
      }

      List<Event> temp = [];

      for (int i = 0; i < extractedRes['events'].length; i++) {
        temp.add(Event.fromJson(extractedRes['events'][i]));
      }

      _events = temp;

      // debugPrint("Number of Events: ");

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  fetchUserBookings({required userId}) async {
    try {
      Map<String, String> qParams = {
        'userId': userId,
      };

      final uri = Uri.http('192.168.17.191:5026', 'book', qParams);
      final res = await http.get(
        Uri.parse(Uri.encodeFull('$uri')),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );
      // debugPrint('$res');
      final extractedRes = await json.decode(res.body);
      debugPrint('result from api ${extractedRes['userBooked']}');
      if (res.statusCode != 200) {
        throw Error();
      }

      List<Book> temp = [];

      for (int i = 0; i < extractedRes['userBooked'].length; i++) {
        temp.add(Book.fromJson(extractedRes['userBooked'][i]));
      }

      _bookedEvents = temp;
//debugPrint('$_bookedEvents');
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
