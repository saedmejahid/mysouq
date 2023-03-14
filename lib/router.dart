
import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/add_product.dart';
import 'package:my_souaq/app/screens/auth_screen.dart';
import 'package:my_souaq/app/screens/home_screen.dart';
import 'package:my_souaq/app/widgets/bottom_bar.dart';
Route<dynamic> generateRoute(RouteSettings routeSettings)
{
  switch(routeSettings.name)
  {
    case AuthScreen.routName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const AuthScreen()
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const HomeScreen()
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const BottomBar()
      );

    case AddProduct.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const AddProduct()
      );

    default: return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const Scaffold(
            body: Center(
              child: Text(
                'No Data Here :(',
              ),
            ),
          )
      );
  }
}