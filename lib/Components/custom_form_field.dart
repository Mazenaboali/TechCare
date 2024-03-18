import 'package:flutter/material.dart';
import 'package:tech_care/utils/validation_utils.dart';

class CustomTextForm extends StatelessWidget {
  String hinttext;
  TextEditingController mycontroller;
  String errorvalidationtext;
  Widget suffixicon;

  CustomTextForm(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
      required this.errorvalidationtext,

        required this.suffixicon,

      }
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return errorvalidationtext;
        }
        if (hinttext == 'ُEmail or phone') {
          if (!ValidationUtils.isValidEmail(text)) {
            return 'Please enter a valid email or Phone number';
          }
        }

        return null;
      },
      controller: mycontroller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          suffixIcon: suffixicon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff023535)),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff023535)),
            borderRadius: BorderRadius.circular(10),
          ),
          label: Text(hinttext,
            style: TextStyle(
              color: Color(0xff023535),
            ),
          )),
    );
  }
}
