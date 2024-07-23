import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatelessWidget{
  String item;
  String iconpath;
  DropDownButtonWidget(this.item,this.iconpath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Container(width: 7,),
            Column(
              children: [
                Image.asset(iconpath,width: 30,height:30 ,),
                Container(height: 10,)
              ],
            ),

            Container(width: 15,),

            Text(
              item,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color:  Color(0xff023535),
              ),
              overflow: TextOverflow.ellipsis,
            ),

          ],
        ),
      ],
    );
  }
}