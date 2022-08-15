import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/social-app/users/users_profile/users_profile.dart';

import '../../../layout/social-app/cubit/cubit.dart';
import '../../../layout/social-app/cubit/states.dart';
import '../../../models/social-app/social_user_mdel.dart';
import '../../../sahred/component/component.dart';
import '../chats/chat_details_screen/chat_details.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0 ,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );

      },
    );
  }
  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage:NetworkImage('${model.image}'),

          ),
          SizedBox(width: 15,),
          Text(
            '${model.name}',
          ),

        ],
      ),
    ),
    onTap: ()
    {
      NavigateTo(context, userProfile(userModel: model,));
    },
  );
  }

