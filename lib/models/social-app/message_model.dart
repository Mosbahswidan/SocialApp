import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String?senderId;
  String?reciverId;
  String?text;
  late int dateTime;
  String? ChatImage;
  MessageModel({
    this.text,
    required this.dateTime,
    this.reciverId,
    this.senderId,
    this.ChatImage
  });
  MessageModel.fromJson(Map<String,dynamic>?json){
    dateTime=json!['dateTime'];
    text=json['text'];
    reciverId=json['reciverId'];
    senderId=json['senderId'];
    ChatImage=json['ChatImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'text':text,
      'senderId':senderId,
      'reciverId':reciverId,
      'dateTime':dateTime,
      'ChatImage':ChatImage,
    };
  }

}