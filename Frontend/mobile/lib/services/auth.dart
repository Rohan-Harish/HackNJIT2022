import 'package:flutter/cupertino.dart';
import 'package:mobile/globals.dart' as global;

class Authentication extends ChangeNotifier{
  String endpoint = ''; //Connect to python backend
  bool _isLoggedIn = false;

  void authenticate(String email, String password) async{
    await Future.delayed(Duration(minutes: 0, seconds: 2), (){
      print("returned after");
    });
      _isLoggedIn = true;
      notifyListeners();
  }

  Future<bool> createAccount(String email, String password, String fullName) async{

    return false;
  }

  bool getStatus(){
    return _isLoggedIn;
  }

  void signOut(){
    print("setting false");
    _isLoggedIn = false;
    notifyListeners();
  }

}