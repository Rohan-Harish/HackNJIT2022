import 'package:flutter/material.dart';

class Globals extends ChangeNotifier{
  bool isLoggedIn = false;

  void setStatus(bool set){
    isLoggedIn = set;
    notifyListeners();
  }
}