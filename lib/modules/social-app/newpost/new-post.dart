import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/cubit/states.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

import '../../../layout/social-app/cubit/cubit.dart';

class newPostScreen extends StatelessWidget {
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Add posts'
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
              TextButton(onPressed: ()
              {
                if(SocialCubit.get(context).postImage==null){
                  SocialCubit.get(context).CreatePost(text: textController.text);
                }else{
                  SocialCubit.get(context).UploadPostPost(text: textController.text);
                }
              },
                  child: Text
                    (
                      'POST'
                  )
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoading)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoading)
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:NetworkImage('${SocialCubit.get(context).socialUserModel!.image}'),

                    ),
                    SizedBox(width: 20,),
                    Expanded(
                        child: Text(
                          '${SocialCubit.get(context).socialUserModel!.name}',
                        )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage!=null)
                Stack(
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
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                       // SocialCubit.get(context).getcoverImage();
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
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getpostImage();
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5,),
                              Text(
                                  'Add photo'
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child:Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


        );
      },
    );
  }
}
