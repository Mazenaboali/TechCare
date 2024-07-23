import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Chat/build-chat-list.dart';
import 'package:tech_care/presentation/Components/message-input-field.dart';
import 'package:tech_care/Provider/get-data-provider.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/database/messageDTO.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;
  String receiverName;
  String senderEmail;
  String? senderName;
  String identifyUser;
  String? receiverImagePath;
  String? senderImagePath;
  ChatScreen(
      {required this.receiverEmail,
      required this.senderEmail,
      required this.identifyUser,
      required this.receiverName,
      this.senderName,
      this.senderImagePath,
      this.receiverImagePath});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.receiverImagePath);
    print(widget.senderImagePath);
    if (widget.identifyUser == "doctor") {
      Provider.of<MyDataProvider>(context, listen: false)
          .fetchDoctorData(doctordocument: widget.senderEmail);
    } else {
      Provider.of<MyDataProvider>(context, listen: false)
          .fetchPatientData(patientdocument: widget.senderEmail);
    }
  }

  void _sendMessage() async {
    String messageContent = _messageController.text.trim();

    String dateTime = DateTime.now().day.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString();
    if (messageContent.isNotEmpty) {
      try {
        MessageDTO message = MessageDTO(
            sender: widget.senderEmail,
            receiver: widget.receiverEmail,
            content: messageContent,
            timestamp: Timestamp.now(),
            receiverName: widget.receiverName,
            senderName: widget.senderName,
            senderImagePath: widget.senderImagePath,
            receiverImagePath: widget.receiverImagePath);
        MyDatabase.insertMessage(message);

        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var myDataProvider = Provider.of<MyDataProvider>(context);
    if (widget.identifyUser == "doctor") {
      widget.senderName = myDataProvider.doctordata?.name;
      widget.senderImagePath = myDataProvider.doctordata?.profileimagepath;
    } else {
      widget.senderName = myDataProvider.patientdata?.name;
      widget.senderImagePath = myDataProvider.patientdata?.profileimagepath;
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(1),
                child: widget.receiverImagePath == null ||
                        widget.receiverImagePath == ""
                    ? ClipOval(
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 50,
                          width: 50,
                        ),
                      )
                    : ClipOval(
                        child: Image.network(
                          widget.receiverImagePath ?? "",
                          fit: BoxFit.fill,
                          height: 50,
                          width: 50,
                        ),
                      )),
            Container(
              width: 10,
            ),
            Text('${widget.receiverName}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BuildChatList(
              receiverEmail: widget.receiverEmail,
              sender: widget.senderEmail,
              receiverImagePath: widget.receiverImagePath,
            ),
          ),
          MessageInputField(
              messageController: _messageController, sendMessage: _sendMessage)
        ],
      ),
    );
  }
}
