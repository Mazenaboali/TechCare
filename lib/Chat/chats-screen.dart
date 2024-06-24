import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Chat/chat-screen.dart';
import 'package:tech_care/Provider/get-data-provider.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/Patient.dart';

import '../database/Doctor.dart';

class ChatsScreen extends StatelessWidget {
  static String routeName = "ChatsScreen";
  String identifyUser;

  ChatsScreen(this.identifyUser);
  Map<String, String?> friendsImagePath={} ;
  Set<String> friends = {};
  Set<String> friendsemail = {};
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void y(String receiver, String sender) async {
      await Provider.of<MyDataProvider>(context, listen: false)
          .fetchData(doctordocument: receiver, patientdocument: sender);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: MyDatabase.getMessages(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);
        // Check if snapshot has data
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No Chats yet'));
        }

        List<DocumentSnapshot> messages = snapshot.data!.docs;

        List<Map<String, dynamic>> dataMatchs = [];
        print(messages.length);
        for (int i = 0; i < messages.length; i++) {
          Map<String, dynamic> data =
              messages[i].data() as Map<String, dynamic>;
          if (data['sender'] == user?.email ||
              data['receiver'] == user?.email) {
            dataMatchs.add(data);
          }
        }

        print(dataMatchs.length);
        for (int index = 0; index < dataMatchs.length; index++) {
          if (dataMatchs[index]['sender'] != user?.email) {

            friendsImagePath.putIfAbsent(dataMatchs[index]['senderName'], () => dataMatchs[index]['senderImagePath']);
            friendsemail.add(dataMatchs[index]['sender']);
            if(dataMatchs[index]['senderName']!=null){
              friends.add(dataMatchs[index]['senderName']);
            }

          } else {
            print(dataMatchs[index]['receiverImagePath']);
            friendsImagePath[dataMatchs[index]['receiverName']]=dataMatchs[index]['receiverImagePath'] ;
            friendsemail.add(dataMatchs[index]['receiver']);
            if(dataMatchs[index]['receiverName']!=null) {
              friends.add(dataMatchs[index]['receiverName']);
            }
          }
        }
        print(friendsImagePath);
        print('object');
        List<String> users = friends.toList();
        List<String> usersEmail = friendsemail.toList();
        print(users.length);
        print(usersEmail.length);
        print(users);
        if(users.length==0){
         return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: Color(0xff191D31)),
              backgroundColor: Colors.white,
              title: Text(
                'chats',
                style: TextStyle(
                    color: Color(0xff191D31), fontWeight: FontWeight.w500),
              ),
            ),
            body: Center(
              child: Text('No chats yet',style: TextStyle(
                fontSize: 22
              ),),
            )
          );
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(color: Color(0xff191D31)),
            backgroundColor: Colors.white,
            title: Text(
              'chats',
              style: TextStyle(
                  color: Color(0xff191D31), fontWeight: FontWeight.w500),
            ),
          ),
          body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              String lastMessage="";
              String lastMessageDate = "";
              for (int i = 0; i < dataMatchs.length; i++) {
                if (dataMatchs[i]['receiver'] == usersEmail[index] ||
                    dataMatchs[i]['sender'] == usersEmail[index]) {
                  lastMessage = dataMatchs[i]['content'];
                  List<String> lines = lastMessage.split('\n');
                  lastMessage= lines.first;
                  Timestamp timestamp = dataMatchs[i]['timestamp'];
                  DateTime dateTime = timestamp.toDate();
                  lastMessageDate = dateTime.day.toString() +
                      "/" +
                      dateTime.month.toString() +
                      "/" +
                      dateTime.year.toString() +
                      "   " +
                      dateTime.hour.toString();
                  ;
                  if (dateTime.hour < 12) {
                    lastMessageDate += 'AM';
                  } else {
                    lastMessageDate += 'PM';
                  }
                  break;
                }
              }
              return InkWell(
                onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                receiverEmail: usersEmail[index],
                                identifyUser: identifyUser,
                                receiverName: users[index],
                                senderEmail: user?.email ?? "",
                                receiverImagePath:
                                friendsImagePath[users[index]],
                              )));
                },
                child: Column(
                  children: [
                    Container(
                        height: 90,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:friendsImagePath[users[index]] == null|| friendsImagePath[users[index]] ==""
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
                                          friendsImagePath[users[index]]??"" ,
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          users[index] ?? "-",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          width: 30,
                                        ),
                                        Text(
                                          lastMessageDate,
                                          style: TextStyle(
                                              color: Color(0xffC5BDBD),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      lastMessage ?? "",
                                      style: TextStyle(
                                          color: Color(0xffC5BDBD),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                    Container(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
