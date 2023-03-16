import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,required this.text, required this.onTap}) : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(
                double.infinity,50
            )
        ),
        onPressed: onTap,
        child: Text(
            text,
        )
    );
  }
}
