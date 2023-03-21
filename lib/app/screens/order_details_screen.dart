import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/orders_model.dart';
import 'package:my_souaq/app/services/admin_services.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/custom_button.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  static const String routeName = '/order-details';
  final Orders order;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{
  int currentState = 0;
  AdminService adminService = AdminService();

  @override
  void initState()
  {
    super.initState();
    currentState = widget.order.status;
  }
  void updateOrderScreen(int status, Orders order)
  {
    adminService.changeOrderStatus(
        context: context,
        status: status + 1,
        order: order,
        onSuccess: () {
          setState(() {
            currentState += 1;
          });
        });
  }
  @override
  Widget build(BuildContext context)
  {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar:  AppBar(
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

              const [
                Text(
                  'Order Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
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
              const Text(
                  'Order Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date:  ${DateTime.fromMillisecondsSinceEpoch(
                        widget.order.orderedAt)}'),
                    Text('ID:    ${widget.order.id}'),
                    Text('Total: \$${widget.order.totalPrice}'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                              widget.order.products[i].images[0],
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(
                                width: 5
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Qty: ${widget.order.products[i].selQty}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 10,
              ),
              const Text(
                'Tracking Order',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentState,
                  controlsBuilder: (context, details) {
                    if (user.type == "admin") {
                      return CustomButton(
                        text: 'Done',
                        onTap: () {
                          updateOrderScreen(details.currentStep,widget.order);
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  steps:
                  [
                    Step(
                        title: const Text(
                            'Pending',
                        ),
                        content: const Text(
                            'We Just Take your Order'
                        ),
                        isActive: currentState >= 0,
                        state: currentState > 0 ? StepState.complete : StepState.indexed
                    ),
                    Step(
                        title: const Text('Preparing'),
                        content: const Text('Your Order is under preparing'),
                        isActive: currentState >= 1,
                        state: currentState > 1 ? StepState.complete : StepState.indexed
                    ),
                    Step(
                        title: const Text('Ready'),
                        content: const Text('Yor Order is ready to shaping'),
                        isActive: currentState >= 2,
                        state: currentState > 2 ? StepState.complete : StepState.indexed
                    ),
                    Step(
                        title: const Text('On way'),
                        content: const Text('Order is On the way'),
                        isActive: currentState >= 3,
                        state: currentState > 3 ? StepState.complete : StepState.indexed
                    ),
                    Step(
                        title: const Text('Completed'),
                        content: const Text('Have Fun with your order'),
                        isActive: currentState >= 4,
                        state: currentState >= 4 ? StepState.complete : StepState.indexed
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

