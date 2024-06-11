import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomButtonAuth({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed:onPressed,
        child: Container(
          width: 328,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [
                Color(0xFF023535),
                Color(0xFF069B9B),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,

              ),
            ),
          ),
        )
      ),
    );
  }
}
