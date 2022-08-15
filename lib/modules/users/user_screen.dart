import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj1/models/users/user_model.dart';




class UserScreen extends StatelessWidget {
  List<userModel> UserMM=[
    userModel(id: 1, name: 'mosbah', phone: '0598707093'),
    userModel(id: 2, name: 'seef', phone: '0599323656'),
    userModel(id: 3, name: 'marwa', phone: '0592028161'),
    userModel(id: 4, name: 'mosbah', phone: '0598707093'),
    userModel(id: 5, name: 'seef', phone: '0599323656'),
    userModel(id: 6, name: 'marwa', phone: '0592028161'),
    userModel(id: 1, name: 'mosbah', phone: '0598707093'),
    userModel(id: 2, name: 'seef', phone: '0599323656'),
    userModel(id: 3, name: 'marwa', phone: '0592028161'),
    userModel(id: 4, name: 'mosbah', phone: '0598707093'),
    userModel(id: 5, name: 'seef', phone: '0599323656'),
    userModel(id: 6, name: 'marwa', phone: '0592028161'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context,index){
          return BuildUserItem(UserMM[index]);

        },
        separatorBuilder: (context,index){
          return Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          );

        },
        itemCount: UserMM.length,
      ),
    );
  }


  Widget BuildUserItem(userModel user) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 26,
          child: Text(
            user.id.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              user.phone,
            ),
          ],
        ),
      ],
    ),
  );
}
