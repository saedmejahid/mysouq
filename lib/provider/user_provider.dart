import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/user_model.dart';

class UserProvider extends ChangeNotifier
{
   User _user = User.getNewEmpty();

  User get user => _user;

  void setUser(String user)
  {
    _user = User.fromJson(user);
    notifyListeners();
  }
}