import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:my_souaq/app/services/home_services.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/loader.dart';
import 'package:my_souaq/app/widgets/single_product.dart';
class CategoryDeal extends StatefulWidget
{
  const CategoryDeal({Key? key, required this.category}) : super(key: key);
  final String category;
  static const  String routeName = "/category-deal";
  @override
  State<CategoryDeal> createState() => _CategoryDealState();
}
class _CategoryDealState extends State<CategoryDeal>
{
  List<Product>?  productList ;
  HomeServices homeServices = HomeServices();
  @override
  void initState()
  {
    super.initState();
    fetchCategory();
  }
  fetchCategory()async
  {
    productList = await homeServices.getCategoryProducts(
        context: context,
        category: widget.category,
    );
    setState((){});
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
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

                [
                  Text(
                    widget.category,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: productList == null ? const Loader():
          GridView.builder(
            padding: const EdgeInsets.only(
              top: 10
            ),
            itemCount: productList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder:(context,index)
              {
                final product = productList![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: product.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      [
                        Expanded(
                          child:Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${product.price} EGP',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
          )
    );
  }
}
