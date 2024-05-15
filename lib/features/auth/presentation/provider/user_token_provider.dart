import 'package:flutter/material.dart';

class UserTokenProvider extends ChangeNotifier{

  String? token;

  void setUserToken(String userToken){
    token = userToken;
    notifyListeners();
  }
}