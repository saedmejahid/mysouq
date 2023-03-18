import 'dart:convert';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:my_souaq/components/error_handling.dart';
import 'package:my_souaq/components/utils.dart';
import 'package:my_souaq/constants/constants.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class HomeServices
{
  Future<List<Product>> getCategoryProducts({
    required BuildContext context,
    required String category,
})async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productsList = [];
    try
    {
      http.Response  res  = await http.get(
        Uri.parse('$myUri01/api/get-products?category=$category'),
        headers:
        {
          'Content-Type':'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
      );
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: ()
          {
            for(int i = 0; i < jsonDecode(res.body).length; i ++)
            {
              productsList.add(
                  Product.fromJson(
                      jsonEncode(jsonDecode(res.body)[i])
                  )
              );
            }
          });
    }
    catch(error)
    {
      showSnackBar(context, error.toString());
    }
    return productsList;

  }

  Future<List<Product>> searchForProduct({
    required BuildContext context,
    required String text,

  })async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productsList = [];
    try
    {
      http.Response  res  = await http.get(
        Uri.parse('$myUri01/api/get-products/search/$text'),
        headers:
        {
          'Content-Type':'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
      );
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: ()
          {
            for(int i = 0; i < jsonDecode(res.body).length; i ++)
            {
              productsList.add(
                  Product.fromJson(
                      jsonEncode(jsonDecode(res.body)[i])
                  )
              );
            }
          });
    }
    catch(error)
    {
      showSnackBar(context, error.toString());
    }
    return productsList;

  }

  Future<List<Product>> dealOfProducts({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$myUri01/api/deal-of-the-day'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(response: res, context: context, onSuccess: () {
        for (int i =0; i < jsonDecode(res.body).length; i ++) {
          productsList.add(
              Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i])
              )
          );
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }
}