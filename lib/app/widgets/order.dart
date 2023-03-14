import 'package:flutter/material.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/single_product.dart';
class Order extends StatefulWidget
{
  const Order({Key? key}) : super(key: key);
  @override
  State<Order> createState() => _OrderState();
}
class _OrderState extends State<Order>
{
  List list =
  [
    'https://via.placeholder.com/600x250/F00',
    'https://via.placeholder.com/600x250/000FF',
    'https://via.placeholder.com/600x250/F0000',
    'https://via.placeholder.com/600x250/000000',
  ];
  @override
  Widget build(BuildContext context)
  {
    return  Column(
      children:
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child:Text(
                'View All',
                style: TextStyle(
                  fontSize: 15,
                  color: Declarations.selectedNavBarColor
                ),
              ),
            ),

          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            right: 5,
            top: 20
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemBuilder:((context,index){
                return SingleProduct(
                    image: list[index]
                );
              }),
            itemCount: list.length,
          ),
        )
      ],
    );
  }
}

