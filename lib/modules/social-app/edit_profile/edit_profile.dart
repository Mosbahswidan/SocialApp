import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/layout/social-app/cubit/states.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel=SocialCubit.get(context).socialUserModel;
        var profileImage=SocialCubit.get(context).profileimage;
        var coverImage=SocialCubit.get(context).coverimage;
        nameController.text=userModel!.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;

        ImageProvider proofimagee;
        if(profileImage==null){
          proofimagee=NetworkImage(
            '${userModel.image}',
          );
        }
        else{
          proofimagee=FileImage(profileImage);
        }

        ImageProvider coovimagee;
        if(coverImage==null){
          coovimagee=NetworkImage(
             '${userModel.cover}',
          );
        }
        else{
          coovimagee=FileImage(coverImage);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Edit profile'
            ),
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(onPressed: (){
                SocialCubit.get(context).updateUser(name:nameController.text, phone:'0599323656' , bio: bioController.text);
              }, child: Text('UPDATE')),
              SizedBox(width: 10,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children:
                          [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coovimagee ,
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getcoverImage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                  child: Icon(
                                IconBroken.Camera,
                                color: Colors.white,
                                    size: 15,
                              )),
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.white,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage:proofimagee,
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getProfileImage();

                              },
                              icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7,),
                if(SocialCubit.get(context).coverimage!=null || SocialCubit.get(context).profileimage!=null )
                Row(
                  children: [
                    if(SocialCubit.get(context).profileimage!=null)
                    Expanded(child: defultButton(background: Colors.blue, text:'Upload profile', function:(){
                      SocialCubit.get(context).uploadprofileImage(name: nameController.text, phone:phoneController.text , bio: bioController.text
                      );
                    })),
                    SizedBox(width: 5,),
                    if(SocialCubit.get(context).coverimage!=null)
                    Expanded(child: defultButton(background: Colors.blue, text:'Upload cover', function:(){
                      SocialCubit.get(context).uploadcoverImage(name: nameController.text, phone:phoneController.text, bio: bioController.text
                      );
                    })),
                  ],
                ),
                SizedBox(height: 20,),
                defaulFormField(
                    control: nameController,
                    labelText: 'Name',
                    type: TextInputType.text,
                    vlaidd: (String value){
                      if(value.isEmpty){
                        return'Name must not be empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.User,
                  onChange: (s){return null;}, ontap: (){return null;}
                ),
                SizedBox(height: 10,),
                defaulFormField(
                    control: bioController,
                    labelText: 'Bio',
                    type: TextInputType.text,
                    vlaidd: (String value){
                      if(value.isEmpty){
                        return'Bio must not be empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Info_Circle,
                    onChange: (s){return null;}, ontap: (){return null;}
                ),
                SizedBox(height: 10,),

                defaulFormField(
                    control: phoneController,
                    labelText: 'Phone',
                    type: TextInputType.phone,
                    vlaidd: (String value){
                      if(value.isEmpty){
                        return'Phone must not be empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Call,
                    onChange: (s){return null;}, ontap: (){return null;}
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
