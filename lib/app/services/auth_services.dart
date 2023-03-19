import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/user_model.dart';
import 'package:my_souaq/app/widgets/bottom_bar.dart';
import 'package:my_souaq/components/error_handling.dart';
import 'package:my_souaq/components/utils.dart';
import 'package:my_souaq/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices{
  void singUpUser({
    required  context,
    required String email,
    required String password,
    required String name
  }) async
  {
    try{
      User user = User.getNewEmpty();
     http.Response res = await http.post(
                               Uri.parse('$myUri01/api/signup'),
                               body: user.toJson(),
                               headers: <String,String>
                               {
                                 'Content-Type': 'application/json; charset=utf-8',
                               });
     httpErrorHandel(
         response: res,
         context: context,
         onSuccess: ()
         {
           showSnackBar(context,'Account Created Now You Can Login');
         }
     );
    }catch(error)
    {
      showSnackBar(context, error.toString());
    }
  }

  void singInUser({
    required  context,
    required String email,
    required String password,
  }) async
  {
    try{

      http.Response res = await http.post(
          Uri.parse('$myUri01/api/signin'),
          body:jsonEncode({
            'email' :email,
            'password':password
          }),
          headers: <String,String>
          {
            'Content-Type': 'application/json; charset=utf-8',
          });
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () async
          {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context,listen: false).setUser(res.body);
            await preferences.setString("my-souq-auth-token", jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName,(route) => false);
            // showSnackBar(context,'Success You Are Welcome :) ');
          }
      );
    }catch(error)
    {
      showSnackBar(context, error.toString());
    }
  }


  void getUserDate( context)async
  {
    try
    {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('my-souq-auth-token');
      if(token == null )
      {
        sp.setString('my-souq-auth-token', '');
      }

     var resToken = await http.post(
        Uri.parse('$myUri01/isValidToken'),
          headers: <String,String>
          {
            'Content-Type': 'application/json; charset=utf-8',
            'my-souq-auth-token' : token!
          }
      );

      var response = jsonDecode(resToken.body);
      if(response == true)
      {
       http.Response userRes = await http.get(
           Uri.parse('$myUri01/'),
           headers: <String,String>
           {
             'Content-Type': 'application/json; charset=utf-8',
             'my-souq-auth-token' : token
           }
       );
       var userProvider = Provider.of<UserProvider>(context,listen: false);
       userProvider.setUser(userRes.body);
      }
    }catch(error)
    {
      showSnackBar(context,error.toString());
    }
  }
}