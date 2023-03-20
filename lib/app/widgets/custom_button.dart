import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,required this.text, required this.onTap, this.icon}) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final IconData ? icon;
  @override
  Widget build(BuildContext context)
  {
    return icon == null ? ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(
                double.infinity,50
            ),
        ),
        onPressed: onTap,
        child: Text(
            text,
        )
    )
        :ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(
                double.infinity,48,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )
        ),
        onPressed: onTap,
        icon: Icon(
            icon,
          size: 25,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18
          ),
        )
    );
  }
}

