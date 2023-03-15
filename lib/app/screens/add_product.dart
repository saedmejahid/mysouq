import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/category_model.dart';
import 'package:my_souaq/app/services/admin_services.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/custom_button.dart';
import 'package:my_souaq/app/widgets/custom_text.dart';
import 'dart:io';

import 'package:my_souaq/components/utils.dart';
class AddProduct extends StatefulWidget
{
  const AddProduct({Key? key}) : super(key: key);
  static const String routeName = '/addProduct';
  @override
  State<AddProduct> createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct>
{
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  final AdminService adminServices =AdminService();
  final productForm = GlobalKey<FormState>();
  String category = 'Mobiles';
  List<File> images = [];
  @override
  void dispose()
  {
    super.dispose();
    productNameController.dispose();
    descriptionNameController.dispose();
    priceController.dispose();
    qtyController.dispose();
  }
  void pickAddImage() async
  {
    var resulet = await pickImage();
    setState(()
    {
      images = resulet;
    });
  }
  void addProducts()
  {
    if(productForm.currentState!.validate() && images.isNotEmpty)
    {
      adminServices.saveProduct(
          context: context,
          name: productNameController.text,
          price: double.parse(priceController.text),
          qty: double.parse(qtyController.text),
          description: descriptionNameController.text,
          category: category,
          images: images
      );
    }
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
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Declarations.greyBackgroundColor,
            ),
            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Add Products',
          )
      ),
      body: SingleChildScrollView(
        child:Form(
          key: productForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children:
                [
                  const SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty ? CarouselSlider(
                    items: images.map((element)
                    {
                      return Builder(
                        builder: (BuildContext context) =>
                            Image.file(
                          element,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1,
                      aspectRatio: 16/9,
                      initialPage: 2,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(milliseconds: 400),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )
                  )
                 : GestureDetector(
                    onTap: pickAddImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [
                          10,
                          4,
                        ],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                             [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select Product Images',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                      formController: productNameController,
                      hintText: 'Product Name'
                  ),
                  const SizedBox(
                    height:10,
                  ),
                  CustomText(
                      formController: descriptionNameController,
                      hintText: 'Description',
                    maxLiens: 4,
                  ),
                  const SizedBox(
                    height:10,
                  ),
                  CustomText(
                    formController: priceController,
                    hintText: 'Price',
                  ),
                  const SizedBox(
                    height:10,
                  ),
                  CustomText(
                    formController: qtyController,
                    hintText: 'Qty',
                  ),
                  const SizedBox(
                    height:10,
                  ),
                  SizedBox(
                    width:double.infinity,
                    child: DropdownButton(
                      items: Components.catImages.map((e)
                      {
                        return DropdownMenuItem(
                          value:  e['title'],
                            child: Text(
                              e['title']!
                            ),
                        );
                      }).toList(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down
                      ),
                      value: category,
                      onChanged: (String? value)
                      {
                        setState(() {
                          category = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height:10,
                  ),
                  CustomButton(
                      text: 'Save',
                      onTap: ()
                      {
                        return addProducts();
                      },
                  ),
                  const SizedBox(
                    height:10,
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
