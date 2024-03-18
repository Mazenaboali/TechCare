import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  bool _isChecked;
  String name;

  CheckBoxWidget(this._isChecked,this.name);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: [
      Text(
       widget.name,
        style: TextStyle(
          color: Color(0xff008F8C),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      Checkbox(
        value: widget._isChecked,
        onChanged: (bool? value) {
          setState(() {
            widget._isChecked = value!;
            print(widget._isChecked);
          });
        },
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
