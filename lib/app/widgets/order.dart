import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/order_details_screen.dart';
import 'package:my_souaq/app/services/home_services.dart';
import 'package:my_souaq/app/models/orders_model.dart';
import 'package:my_souaq/components/utils.dart';
class Order extends StatefulWidget
{
  const Order({Key? key}) : super(key: key);
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order>
{
  List<Orders>?orders;
  HomeServices homeServices = HomeServices();
  @override
  void initState()
  {
    super.initState();
    getAllUsersOrders();

  }
  void getAllUsersOrders()async
  {
    orders = await homeServices.getMyOrders(context: context);
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            Row(
              children:
              const [
                 Text(
                  'Orders',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children:
              [
                TableRow(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    children:
                    [
                      tableHeader('Order'),
                      tableHeader('Amount'),
                      tableHeader('Status'),
                      tableHeader(""),
                    ]),
               if(orders != null)
                 for(int i =0; i < orders!.length;i++)
                   tableRow(
                     context,
                     image: orders![i].products[0].images[0],
                     amount: orders![i].totalPrice.toString(),
                     status: orders![i].status,
                     index: (i + 1).toString(),
                     i: i
                   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  TableRow tableRow (context,{index,image,amount,  required int status,required int i})
  {
    return  TableRow(
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            )
        ),
        children:
        [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Row(
              children:
              [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    1000,
                  ),
                  child: Image.network(
                    image,
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  index,
                ),
              ],
            ),
          ),
          Text(
            amount,
          ),
          Row(
            children:
            [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:getStatusColor(status)
                ),
                height: 10,
                width: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                getStatus(status),
              ),
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
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: const Center(
                child: Text(
                  'View',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ]
    );
  }
  Widget tableHeader(text)
  {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}


