import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/layout/social-app/cubit/states.dart';

import '../../../../models/social-app/message_model.dart';
import '../../../../models/social-app/social_user_mdel.dart';
import '../../../../sahred/styles/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel ?userModel;
  ChatDetails({
    this.userModel
});
  var MessageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(
        reciverId: userModel!.uId!,
      );

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<MessageModel> message = SocialCubit.get(context).messages;
          //message=message.reversed.toList();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      userModel!.image!,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    userModel!.name!,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index)
                      {
                        if(SocialCubit.get(context).socialUserModel!.uId == message[index].senderId) {
                          return buildMyMessage(message[index],context);
                        }
                        return buildMessage(message[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                  ),
                  if(SocialCubit.get(context).chatImage!=null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children:
                      [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: FileImage(SocialCubit.get(context).chatImage!),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            SocialCubit.get(context).deleteChatImage();
                          },
                          icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                IconBroken.Close_Square,
                                color: Colors.white,
                                size: 15,
                              )),
                        ),
                      ],
                    ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,

                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              controller: MessageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {
                              if(SocialCubit.get(context).chatImage==null) {
                                SocialCubit.get(context).SendMessgae(
                                reciverId: userModel!.uId!,
                                dateTime: DateTime.now().microsecondsSinceEpoch,
                                text: MessageController.text,

                              );
                              }else{
                                SocialCubit.get(context).UploadChat(
                                  reciverId: userModel!.uId!,
                                  dateTime: DateTime.now().microsecondsSinceEpoch,
                                  text: MessageController.text,
                                  ChatImage: SocialCubit.get(context).chatImage!.path,
                                  uiid: userModel!.uId
                                );
                              }
                              SocialCubit.get(context).deleteChatImage();
                              SocialCubit.get(context).SendNotification(userModel!,"message from ${SocialCubit.get(context).socialUserModel!.name}");
                            },
                            minWidth: 1.0,
                            child: Icon(
                              IconBroken.Send,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          height: 50.0,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {
                              SocialCubit.get(context).getchatImage();

                            },
                            minWidth: 1.0,
                            child: Icon(
                              IconBroken.Image,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
    );}

  Widget buildMyMessage(MessageModel model,context) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Text(
            '${model.text}',
          ),
          if(model.ChatImage!=null)
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children:
              [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(model.ChatImage!),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Text(
            '${model.text}',
          ),
          if(model.ChatImage!=null)
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children:
              [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(model.ChatImage!),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );


}


