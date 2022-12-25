import 'dart:convert';
import 'dart:io';
import 'package:booking_app/models/user.model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isAuth => _currentUser != null;

  login({required String name, required String password}) async {
    try {
      final response = await http.post(
        //http://10.0.2.2:5019/auth/login
        Uri.parse('http://192.168.17.191:5026/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': name, 'password': password}),
      );

      debugPrint(response.body);

      // Turns json file into Map<String, dynamic>
      final extractedRes = await json.decode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(extractedRes['message']);
      }

      _currentUser = User.fromJson(extractedRes['user']);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  registerUser({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      String formatedPhone =
          '+251${phoneNumber.substring(phoneNumber.length - 9)}';
      //  debugPrint('the phone is $formatedPhone');
      //192.168.17.191
      final response = await http.post(
        Uri.parse('http://192.168.17.191:5026/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': name,
          'email': email,
          'phonenumber': phoneNumber,
          'password': password
        }),
      );
      debugPrint(response.body);

      final extractedRes = await json.decode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(extractedRes['message']);
      }

      _currentUser = User.fromJson(extractedRes['newUser']);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  forgot({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.17.191:5026/auth/forgot'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
        }),
      );

      debugPrint(response.body);
      final extractedRes = await json.decode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(extractedRes['message']);
      }
       _currentUser = User.fromJson(extractedRes);
       notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

 reset({required id,required token}) async {
    try {
      Map<String, String> Params = {
        'id':id,
        'token':token
      };

      final uri = Uri.http('192.168.17.191:5026', 'reset', Params);
      final res = await http.get(
        Uri.parse(Uri.encodeFull('$uri')),
        headers: {
            
          HttpHeaders.contentTypeHeader: "application/json"},
      );
    
      final extractedRes = await json.decode(res.body);
      debugPrint('result from api ${extractedRes['email']}');
      if (res.statusCode != 200) {
        throw Error();
      }

    
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
