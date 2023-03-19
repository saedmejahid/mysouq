import 'package:flutter/material.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/custom_text.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
class AddressScreen extends StatefulWidget
{
   const AddressScreen({Key? key}) : super(key: key);
  static const String routeName = '/address';
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}
class _AddressScreenState extends State<AddressScreen>
{
  final TextEditingController addressController =TextEditingController();
  final TextEditingController numberController =TextEditingController();
  final TextEditingController areaController =TextEditingController();
  final TextEditingController markController =TextEditingController();
  final addressFormKey = GlobalKey<FormState>();
  @override
  void dispose()
  {
    super.dispose();
    addressController.dispose();
    numberController.dispose();
    areaController.dispose();
    markController.dispose();
  }
  @override
  Widget build(BuildContext context)
  {
    var address = context.watch<UserProvider>().user.address;
    return  Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Declarations.appBarGradient
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
         const [
            Text(
              'Add Your Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              if(address.isNotEmpty)
                Column(
                  children:
                  [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Or You Have New Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Form(
                key: addressFormKey,
                  child: Column(
                    children:
                    [
                      CustomText(
                        formController: addressController,
                        hintText: 'Address',
                        icon: Icons.home_outlined,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        formController: numberController,
                        hintText: ' Home, Number',
                        icon: Icons.streetview_outlined,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        formController: areaController,
                        hintText: ' Area, Street',
                        icon: Icons.add_business_outlined,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        formController: markController,
                        hintText: ' Special, Mark',
                        icon: Icons.markunread_mailbox_outlined,
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
