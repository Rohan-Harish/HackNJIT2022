import 'package:flutter/cupertino.dart';
import 'package:mobile/globals.dart' as global;
import 'network.dart';
import 'package:http/http.dart' as http;

class Authentication extends ChangeNotifier {
  String endpoint = ''; //Connect to python backend
  bool _isLoggedIn = false;
  Networking net = Networking("http://10.208.192.22", "5000");

  void authenticate(String email, String password) async {
    http.Response response =
        await net.sendPost('login', {"email": email, "password": password});
    print(response);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<bool> createAccount(
      String email, String password, String fullName) async {
    return false;
  }

  bool getStatus() {
    return _isLoggedIn;
  }

  void signOut() {
    print("setting false");
    _isLoggedIn = false;
    notifyListeners();
  }
}
