import 'package:flutter/material.dart';
class DealOfDay extends StatefulWidget
{
  const DealOfDay({Key? key}) : super(key: key);
  @override
  State<DealOfDay> createState() => _DealOfDayState();
}
class _DealOfDayState extends State<DealOfDay>
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 10,
            top: 15,
          ),
         child: const Text(
            'Deal Of Day',
           style: TextStyle(
             fontSize: 20,
           ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Image.network(
          'https://eg.jumia.is/cms/Ramadan-23/Banks/INSTAL8.gif'
        )
      ],
    );
  }
}

