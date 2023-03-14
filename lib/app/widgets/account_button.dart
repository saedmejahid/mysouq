import 'package:flutter/material.dart';
class AccountButton extends StatelessWidget
{
  const AccountButton({Key? key, required this.text, required this.onClick}) : super(key: key);
  final String text;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context)
  {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          ),
            onPressed: onClick,
            child: Text(
                text,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
        )),
      ),
    );
  }
}
