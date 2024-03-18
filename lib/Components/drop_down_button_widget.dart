import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatelessWidget{
  String item;
  DropDownButtonWidget(this.item);

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

                Image.asset('assets/images/drop_down_icon/Dentistry.png',width: 30,height:30 ,),
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