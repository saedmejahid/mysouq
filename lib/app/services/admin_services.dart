import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_souaq/app/models/orders_model.dart';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:my_souaq/app/models/sales_model.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/components/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:my_souaq/components/utils.dart';
import 'package:my_souaq/constants/constants.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
class AdminService
{
  void saveProduct({
    required  context,
    required String name,
    required double price,
    required String description,
    required double qty,
    required String category,
    required List<File> images,
  })async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try
    {
      final cloud = CloudinaryPublic('dkmunh6tj','gphsjjwj' );
      List<String> imageUrls = [];
      for(int i =0; i < images.length; i++)
      {
       CloudinaryResponse res = await cloud.uploadFile(
            CloudinaryFile.fromFile(images[i].path,folder: category)
        );
       imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          price: price,
          description: description,
          qty: qty,
          category: category,
          images: imageUrls
      );
     http.Response res = await http.post(
        Uri.parse(
          '$myUri01/admin/add-product'
        ),
          headers:
          {
            'Content-Type':'application/json; charset=utf-8',
            'my-souq-auth-token': userProvider.user.token
          },
        body: product.toJson(),
      );
     httpErrorHandel(
         response: res,
         context: context,
         onSuccess: ()
         {
           showSnackBar(context, 'your product has been added :)');
           Navigator.pop(context);
         });
    }
    catch(error)
    {
      showSnackBar(context, 'Some error ${error.toString()}');
    }
  }

 Future<List<Product>> getAllProducts( context) async
 {
   final userProvider = Provider.of<UserProvider>(context,listen: false);
   List<Product> productsList = [];
   try
   {
    http.Response  res  = await http.get(
       Uri.parse('$myUri01/admin/get-products'),
       headers:
       {
         'Content-Type':'application/json; charset=utf-8',
         'my-souq-auth-token': userProvider.user.token
       },
     );
    httpErrorHandel(
        response: res,
        context:  context,
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

  void deleteProduct({required  context,required Product product,required VoidCallback onSuccess})async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try
    {
      http.Response  res  = await http.post(
        Uri.parse('$myUri01/admin/delete-products'),
        headers:
        {
          'Content-Type':'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
        body: jsonEncode(
          {
            'id':product.id
          }
        )
      );
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: ()
          {
            onSuccess();
          });
    }
    catch(error)
    {
      showSnackBar(context, error.toString());
    }

  }

  Future<List<Orders>> getAllOrders({
    required  context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Orders> orderList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$myUri01/api/all-orders-admin'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
      );
      httpErrorHandel(response: res, context: context, onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body).length; i ++) {
          orderList.add(
              Orders.fromJson(
                  jsonEncode(jsonDecode(res.body)[i])
              )
          );
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus({
    required  context,
    required int status,
    required Orders order,
    required VoidCallback onSuccess
  })async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('$myUri01/admin/update-order-status'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'my-souq-auth-token': userProvider.user.token
          },
          body: jsonEncode(
              {
                'id': order.id,
                'status': status
              }
          )
      );
      httpErrorHandel(response: res, context: context, onSuccess: () {
        onSuccess();
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  Future<Map<String, dynamic>> getTotalSales(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalSales = 0;
    double totalOrders = 0;
    double totalProducts = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$myUri01/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(response: res, context: context, onSuccess: () {
        var result = jsonDecode(res.body);
        totalSales = Declarations.checkDouble(result['totalSales'] ?? 0.0);
        totalOrders = Declarations.checkDouble(result['totalOrders'] ?? 0.0);
        totalProducts = Declarations.checkDouble(result['totalProducts'] ?? 0.0);
        sales = [
          Sales(label: 'Mobiles', totalSale: Declarations.checkDouble(result['catMobiles'] ?? 0.0)),
          Sales(label: 'Appliances', totalSale: Declarations.checkDouble(result['catAppliances'] ?? 0.0)),
          Sales(label: 'Fashion', totalSale: Declarations.checkDouble(result['catFashion'] ?? 0.0)),
          Sales(label: 'Essentials', totalSale: Declarations.checkDouble(result['catEssentials'] ?? 0.0)),
          Sales(label: 'Computers', totalSale: Declarations.checkDouble(result['catComputers'] ?? 0.0)),
        ];
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalSales': totalSales,
      'totalOrders': totalOrders,
      'totalProducts':totalProducts
    };
  }


}