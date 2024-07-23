import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget{
  TextEditingController messageController;
  Function() sendMessage;

  MessageInputField({required this.messageController,required this.sendMessage});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(

              keyboardType: TextInputType.multiline,
              maxLines: null,
               // Set the text input action to "newline"

              controller: widget.messageController,
              decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Color(0xff058383),
            ),
            onPressed: widget.sendMessage,
          ),
        ],
      ),
    );
  }
}