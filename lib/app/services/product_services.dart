import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:my_souaq/app/models/user_model.dart';
import 'package:my_souaq/components/error_handling.dart';
import 'package:my_souaq/components/utils.dart';
import 'package:my_souaq/constants/constants.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class ProductServices {

  void rateProduct({
    required  context,
    required Product product,
    required double rating
  }) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$myUri01/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: ()
          {
        showSnackBar(
            context, 'product has been rated successfully',
        );
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addProductToCart({
    required  context,
    required Product product,
    required double qty }) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try
    {
      http.Response res;
       if(qty < 0)
       {
         res = await http.delete(
           Uri.parse('$myUri01/api/remove-from-cart/${product.id}'),
           headers: {
             'Content-Type': 'application/json; charset=utf-8',
             'my-souq-auth-token': userProvider.user.token
           },
         );
       }else
       {
         res = await http.post(
           Uri.parse('$myUri01/api/add-to-cart'),
           headers: {
             'Content-Type': 'application/json; charset=utf-8',
             'my-souq-auth-token': userProvider.user.token
           },
           body: jsonEncode({
             'id': product.id!,
             'qty': qty,
           }),
         );
       }

      httpErrorHandel(response: res, context: context, onSuccess: () {
        User user = userProvider.user.copyWith(
          cart: jsonDecode(res.body)['cart'],
        );
        userProvider.setObjectUser(user);
        if(qty > 0) {
          showSnackBar(context, 'product has been added successfully');
          Navigator.pop(context);
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void saveUserAddress({
    required  context,
    required String address,
  }) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$myUri01/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: ()
          {
            User user = userProvider.user.copyWith(
              address: jsonDecode(res.body)['address'],
            );
            userProvider.setObjectUser(user);
            showSnackBar(
              context, 'Ok Address Has benn Updated',
            );
          });
    } catch (e) {
       e.toString();
    }
  }

  void setAnOrder({
    required  context,
    required String paymentMethod,
    required String address,
    required double totalPrice,
  }) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$myUri01/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'cart':userProvider.user.cart,
          'address': address,
          'paymentMethod': paymentMethod,
          'totalPrice': totalPrice,
        }),
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: ()
          {
            User user = userProvider.user.copyWith(
              cart:[],
            );
            userProvider.setObjectUser(user);
            showSnackBar(
              context, 'Ok Order Send Successfully',
            );
            Navigator.pop(context);
          });
    } catch (e) {
      e.toString();
    }
  }
}