import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/product_model.dart';
import 'package:my_souaq/app/screens/add_product.dart';
import 'package:my_souaq/app/services/admin_services.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/loader.dart';
import 'package:my_souaq/app/widgets/single_product.dart';
import 'package:my_souaq/components/utils.dart';
class PostScreen extends StatefulWidget
{
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}
class _PostScreenState extends State<PostScreen>
{
  final AdminService adminService = AdminService();
  List<Product> ? products;

  @override
  void initState()
  {
    super.initState();
    getAllProducts();
  }

  getAllProducts ()async
  {
    products =  await adminService.getAllProducts(context);
    setState((){});
  }
  void deleteProduct(Product product,int index)
  {
    adminService.deleteProduct(
        context: context,
        product: product,
        onSuccess:()
        {
          products!.removeAt(index);
          setState((){});
        });
  }
  @override
  Widget build(BuildContext context)
  {
    return products ==null ? const Loader() : Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context,index)
            {
              final theProduct = products![index];
              return Column(
                children:
                [
                  SizedBox(
                    height: 140,
                    child: SingleProduct(
                      image: theProduct.images[0],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                            child:Text(
                              theProduct.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                        ),
                      ),
                      IconButton(
                          onPressed: ()
                          {
                            showAlertDialog(
                                context,
                                    ()
                                {
                                  deleteProduct(theProduct, index);
                                  Navigator.pop(context);
                                },
                                'Delete Product',
                                'Are You Sure To Delete this Product ?'
                            );
                            },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                          ),
                      ),
                    ],
                  )
                ],
              );
            }),
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
