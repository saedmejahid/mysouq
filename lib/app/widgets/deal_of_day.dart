import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:my_souaq/app/screens/product_details_screen.dart';
import 'package:my_souaq/app/services/home_services.dart';
import 'package:my_souaq/app/widgets/loader.dart';
import 'package:my_souaq/app/widgets/product_card_horizontal.dart';
class DealOfDay extends StatefulWidget
{
  const DealOfDay({Key? key}) : super(key: key);
  @override
  State<DealOfDay> createState() => _DealOfDayState();
}
class _DealOfDayState extends State<DealOfDay>
{
  List<Product>? productList;
  HomeServices homeService = HomeServices();
  @override
  void initState()
  {
    super.initState();
    fetchCategories();
  }
  fetchCategories() async
  {
    productList = await homeService.dealOfProducts(
        context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal of the day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
            height: 500,
            width: double.infinity,
            child: productList == null ? const Loader() : ListView.builder(
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailScreen.routeName,
                      arguments: productList![index],
                    );
                  },
                  child: ProductCardHorizontal(
                    product: productList![index],
                  ),

                );
              },)
        )
      ],
    );
  }
}



