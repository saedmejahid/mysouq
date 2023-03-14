import 'package:flutter/material.dart';

class CustomText extends StatelessWidget
{
  const CustomText({Key? key,required this.formController,required this.hintText,this.maxLiens =1}) : super(key: key);
  final TextEditingController formController;
  final String hintText;
  final int maxLiens;

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      controller: formController,
      decoration:  InputDecoration(
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

