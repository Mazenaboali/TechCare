import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildChatList extends StatefulWidget
{
  String sender;

  String receiverEmail;
  String? receiverImagePath;

  BuildChatList({required this.sender, required this.receiverEmail,this.receiverImagePath});

  @override
  State<BuildChatList> createState() => _BuildChatListState();
}

class _BuildChatListState extends State<BuildChatList> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);
        // Check if snapshot has data
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No messages yet'));
        }

        List<DocumentSnapshot> messages = snapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
            messages[index].data() as Map<String, dynamic>;
            if (data['sender'] == widget.sender &&
                data['receiver'] == widget.receiverEmail) {
              double _scale = 1.0; // Initial scale factor
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          return GestureDetector(
                            onScaleUpdate: (ScaleUpdateDetails details) {
                              setState(() {
                                _scale = details.scale.clamp(0.5,
                                    2.0); // Restrict scale factor between 0.5 and 2.0
                              });
                            },
                            child: Transform.scale(
                              scale: _scale,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff90DBD0),
                                  border: Border.all(
                                    color: Color(0xff90DBD0), // لون البوردر
                                    width: 2, // عرض البوردر
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['content'],
                                    style: TextStyle(
                                      color: Color(0xff007665),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              );
            } else if (data['sender'] == widget.receiverEmail &&
                data['receiver'] == widget.sender) {
              double _scale = 1.0;
              return ListTile(
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.receiverImagePath == null ||
                          widget.receiverImagePath == ""
                          ? ClipOval(
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 50,
                          width: 50,
                        ),
                      )
                          : ClipOval(
                          child: Image.file(
                              fit: BoxFit.fill,
                              height: 50,
                              width: 50,
                              File(
                                widget.receiverImagePath ?? "",
                              ))),
                      SizedBox(
                        width: 10,
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        return GestureDetector(
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            setState(() {
                              _scale = details.scale.clamp(0.5,
                                  2.0); // Restrict scale factor between 0.5 and 2.0
                            });
                          },
                          child: Transform.scale(
                            scale: _scale,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffE8F3F1),
                                border: Border.all(
                                  color: Color(0xffE8F3F1), // لون البوردر
                                  width: 2, // عرض البوردر
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['content'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}