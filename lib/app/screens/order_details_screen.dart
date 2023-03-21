import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/orders_model.dart';
import 'package:my_souaq/app/styles/colors.dart';
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  static const String routeName = '/order-details';
  final Orders order;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: Declarations.appBarGradient
          ),
        ),
        leading: IconButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Row(
              children:

              const [
                Text(
                  'Order Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

