import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserTokenProvider extends ChangeNotifier{

  String? token;
  UserEntity? userLoggedIn;

  void setUserToken(String userToken){
    token = userToken;
    notifyListeners();
  }

  void setUser(UserEntity user){
    userLoggedIn = user;
    notifyListeners();
  }
}