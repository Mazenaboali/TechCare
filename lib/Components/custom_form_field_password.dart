import 'package:flutter/material.dart';

class CustomTextFormPassword extends StatefulWidget {
  String hinttext;
  TextEditingController mycontroller;
  String errorvalidationtext;
  CustomTextFormPassword(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
      required this.errorvalidationtext});

  @override
  State<CustomTextFormPassword> createState() => _CustomTextFormPasswordState();
}

class _CustomTextFormPasswordState extends State<CustomTextFormPassword> {
  bool securedpassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return widget.errorvalidationtext;
        }
        if (text.length < 6) {
          return 'Password should at least 6 characters';
        }
        return null;
      },

      controller: widget.mycontroller,
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff023535)),
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: InkWell(
            onTap: () {
              securedpassword == true
                  ? securedpassword = false
                  : securedpassword = true;
              setState(() {});
            },
            child: securedpassword == true
                ? Icon(
                    Icons.visibility_off,
                    color: Color(0xff023535),
                  )
                : Icon(Icons.visibility, color: Color(0xff023535)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff023535)),
            borderRadius: BorderRadius.circular(10),
          ),
          label: Text(
            widget.hinttext,
            style: TextStyle(
              color: Color(0xff023535),
            ),
          )),
      obscureText: securedpassword,
    );
  }
}
