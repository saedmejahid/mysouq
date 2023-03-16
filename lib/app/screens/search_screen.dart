import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:my_souaq/app/services/home_services.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/loader.dart';
import 'package:my_souaq/app/widgets/product_card.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key,required this.searchText}) : super(key: key);
  static const String routeName = "/search-screen";
  final String searchText;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen>
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
    productList = await homeServices.searchForProduct(
      context: context,
      text: widget.searchText,
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
              Row(
                children:

                [
                  Text(
                    'Search Result For ${widget.searchText}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
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
              return ProductCard(
                  product: product,
                  isLiked:false
              );
            }
        )
    );
  }
}

