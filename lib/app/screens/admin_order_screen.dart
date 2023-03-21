import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/orders_model.dart';
import 'package:my_souaq/app/screens/order_details_screen.dart';
import 'package:my_souaq/app/services/admin_services.dart';
import 'package:my_souaq/app/widgets/loader.dart';
import 'package:my_souaq/components/utils.dart';
class AdminOrdersScreen extends StatefulWidget
{
  const AdminOrdersScreen({Key? key}) : super(key: key);
  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}
class _AdminOrdersScreenState extends State<AdminOrdersScreen>
{
  List<Orders>? orders;
  AdminService adminService = AdminService();
  @override
  void initState()
  {
    super.initState();
    getAllAdminOrders();
  }
  void getAllAdminOrders() async
  {
    orders = await adminService.getAllOrders(context: context);
    setState(() {});
  }
  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const
            [
              Text(
                "Orders",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.5, color: Colors.grey,),
          orders == null ? const Loader() : Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children:
              [
                // table head
                TableRow(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: Colors.grey, width: 0.5))),
                    children: [
                      tableHeader("Order"),
                      tableHeader("Amount"),
                      tableHeader("Status"),
                      tableHeader(""),
                    ]),
                //table data
                if(orders != null)
                  for (int i = 0; i < orders!.length; i ++)
                    tableRow(context,
                        image: orders![i].products[0].images[0],
                        amount: orders![i].totalPrice.toString(),
                        status: orders![i].status,
                        index: (i + 1).toString(),
                        i: i)
              ]
          ),
        ],
      ),
    );
  }

  TableRow tableRow(context, {index, image, amount,required int status, required int i}) {
    return TableRow(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                    image,
                    width: 30,
                  ),
                ),
                const SizedBox(width: 10,),
                Text(index)
              ],
            ),
          ),
          Text(amount),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getStatusColor(status)
                ),
                height: 10,
                width: 10,
              ),
              const SizedBox(width: 10,),
              Text(getStatus(status)),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                  arguments: orders![i]);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              child: const Center(
                child: Text(
                  "view",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          )
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
