import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

import '../../../layout/social-app/cubit/states.dart';
import '../edit_profile/edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel=SocialCubit.get(context).socialUserModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image:  NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage:  NetworkImage(
                          '${userModel.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text(
                '${userModel.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                '${userModel.bio}',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '250',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Photos',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '10k',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '120',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: OutlinedButton(
                    onPressed: (){},
                    child: Text(
                      'Add photos'
                    ),
                  )),
        SizedBox(width: 10,),
        OutlinedButton(
        onPressed: (){
          NavigateTo(context, EditProfileScreen());
        },
        child: Icon(
          IconBroken.Edit,
          size: 17,
        ),
        )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
