import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/add_product.dart';
import 'package:my_souaq/app/styles/colors.dart';
class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      body: const Center(
        child: Text(
          'PostsScreen'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Declarations.unselectedNavBarColor,
        tooltip: 'Add Product',
        onPressed: ()
        {
          Navigator.pushNamed(context, AddProduct.routeName);
        },
        child: const Icon(
          Icons.control_point_sharp,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
