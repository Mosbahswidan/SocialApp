import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/layout/social-app/cubit/states.dart';
import 'package:proj1/modules/social-app/newpost/new-post.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit=SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is SocialAddPostState)
          NavigateTo(context, newPostScreen());

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottomNavIndex(index);
          },
            items: [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.User),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),

            ],
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).socialUserModel!=null,
            builder: (context) {
              var model=SocialCubit.get(context);
              return cubit.Screens[cubit.currentIndex];
            },
            fallback: (context) => Container(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
