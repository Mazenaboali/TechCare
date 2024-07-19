import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String? sender;
  String? receiver;
  String? content;
  Timestamp timestamp;
  String? receiverName;
  String? senderName;
  String? senderImagePath;
  String? receiverImagePath;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
    required this.receiverName,
    required this.senderName,
    required this.senderImagePath,
    required this.receiverImagePath
  }
  );

  Message.FromFirestore(Map<String, dynamic> data)
      : this(
     sender: data['sender'],
    content: data['content'],
    receiver: data['receiver'],
    receiverImagePath: data['receiverImagePath'],
    receiverName: data['receiverName'],
    senderImagePath: data['senderImagePath'],
    senderName: data['senderName'],
    timestamp: data['timestamp']

  );
  Map<String, dynamic> ToFirestore() {
    return {
      'sender':sender,
      'content': content,
      'receiver': receiver,
      'receiverImagePath': receiverImagePath,
      'receiverName': receiverName,
      'senderImagePath': senderImagePath,
      'senderName': senderName,
      'timestamp': timestamp,
    };
  }
}