import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAksu5jpTpzZCkIHkrUr08C0w3i-5PVPdE';
    await http
        .post(Uri.parse(url),
            body: json.encode({
              'email': email,
              'password': password,
              'returnSecureToken': true,
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }
}
