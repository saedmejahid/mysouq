import 'package:flutter/material.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/below_appbar.dart';
import 'package:my_souaq/app/widgets/order.dart';
import 'package:my_souaq/app/widgets/top_buttons.dart';
class AccountScreen extends StatelessWidget
{
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: Declarations.appBarGradient
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 95,
                    height: 45,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15,
                      right: 15
                  ),
                  child: Row(
                    children:
                    const [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 15
                        ),
                        child: Icon(
                            Icons.notification_add_outlined
                        ),
                      ),
                      Icon(
                          Icons.search_outlined
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
      body: Column(
        children:
        const [
          BelowAppBar(),
          SizedBox(
              height: 10
          ),
          TopButtons(),
          SizedBox(height: 10,),
          Order()
        ],
      )
    );
  }
}

