import 'package:flutter/material.dart';

class CustomText extends StatelessWidget
{
  const CustomText({
    Key? key,
    required this.formController,
    required this.hintText,
    this.maxLiens =1,
    this.icon
  }) : super(key: key);
  final TextEditingController formController;
  final String hintText;
  final int maxLiens;
  final IconData ? icon;

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      controller: formController,
      decoration:  InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38
          )
        )
      ),
      validator: (validate)
      {
        if(validate == null || validate.isEmpty)
        {
          return hintText;
        }
        return null;
      },
      maxLines: maxLiens,
    );
  }
}

