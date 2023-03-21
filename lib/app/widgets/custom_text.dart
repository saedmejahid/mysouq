import 'package:flutter/material.dart';

class CustomText extends StatefulWidget
{
  const CustomText({
    Key? key,
    required this.formController,
    required this.hintText,
    this.maxLiens =1,
    this.icon,
    this.isPassword = false
  }) : super(key: key);
  final TextEditingController formController;
  final String hintText;
  final int maxLiens;
  final IconData ? icon;
  final bool isPassword;


  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  bool invisible = false;

  @override
  void initState() {
    super.initState();
    invisible == widget.isPassword;
  }
  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      obscureText: invisible,
      controller: widget.formController,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.isPassword ? IconButton(
            onPressed: () {
              setState(() {
                invisible = !invisible;
              });
            },
            icon: Icon(invisible ? Icons.visibility_off_outlined : Icons.visibility_outlined)
        )  : null ,
        hintText: widget.hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
      ),
      validator: (val) {
        if ( val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
      maxLines: widget.maxLiens,
    );
  }
}

