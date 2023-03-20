import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/address_screen.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/address_bar.dart';
import 'package:my_souaq/app/widgets/cart_suptotal.dart';
import 'package:my_souaq/app/widgets/custom_button.dart';
import 'package:my_souaq/app/widgets/product_card_cart.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['qty'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: Declarations.appBarGradient
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Your Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children:
            [
              const AddressBar(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Proceed to Buy (${user.cart.length} items)',
                  onTap: ()
                  {
                    Navigator.pushNamed(context, AddressScreen.routeName,arguments:sum.toString());
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(height: 5),
              ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductCardCart(
                    index: index,
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}
