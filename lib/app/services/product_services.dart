import 'dart:convert';
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
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}