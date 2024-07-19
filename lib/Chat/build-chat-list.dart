import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/messages.dart';

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
    return  StreamBuilder<QuerySnapshot<Message>>(
      stream: MyDatabase.getMessages(),
      builder:  (buildcontext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);
        // Check if snapshot has data
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No messages yet'));
        }

        var messages = snapshot.data?.docs.map((doc) => doc.data()).toList();

        return ListView.builder(
          reverse: true,
          itemCount: messages?.length,
          itemBuilder: (context, index) {
            if (messages![index].sender== widget.sender &&
                messages[index].receiver== widget.receiverEmail) {
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
                                    messages[index].content??"",
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
            } else if (messages[index].sender == widget.receiverEmail &&
                messages[index].receiver== widget.sender) {
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
                          child: Image.network(
                              fit: BoxFit.fill,
                              height: 50,
                              width: 50,

                                widget.receiverImagePath ?? "",
                              ),
                      ),
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
                                  messages[index].content??"",
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