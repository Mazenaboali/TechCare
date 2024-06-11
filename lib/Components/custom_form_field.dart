import 'package:flutter/material.dart';
import 'package:tech_care/utils/validation_utils.dart';

class CustomTextForm extends StatelessWidget {
  String hinttext;
  TextEditingController mycontroller;
  String? errorvalidationtext;
  Widget? suffixicon;
  int? maxLines;
  int? minLines;


  CustomTextForm(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
       this.errorvalidationtext,
        this.suffixicon,
        this.maxLines,
        this.minLines
      }
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: maxLines,
      maxLines: minLines,
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
      hintStyle:  TextStyle(
          color: Color(0xff667085),
    ),
        hintText: hinttext,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEAECF0))
        ),
          filled: true,
          fillColor: Color(0xffF2F4F7),
          suffixIcon: suffixicon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffEAECF0)),
            borderRadius: BorderRadius.circular(8),
          ),
          alignLabelWithHint: true,
      )
    );
  }
}
