import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldOTP extends StatelessWidget {
  bool first;
  bool last;
  bool correct;
  BuildContext context;
  TextEditingController controller;
  TextFieldOTP(
      {required this.first,
      required this.last,
      required this.controller,
      required this.correct,
      required this.context
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1.5,
              color: correct == true ? Colors.blueGrey : Colors.red)),
      child: TextFormField(
        onChanged: ((value) {
          if (value.isNotEmpty && last == false) {
            Focus.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            Focus.of(context).previousFocus();
          }
        }),
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
        decoration: InputDecoration(
            border: InputBorder.none,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 7,
                maxHeight: MediaQuery.sizeOf(context).width / 7)),
      ),
    );
  }
}
