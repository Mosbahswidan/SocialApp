//import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/models/social-app/post_model.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

import '../../../layout/social-app/cubit/states.dart';
import '../comments_screen/comments_screen.dart';



class FeedsScreen extends StatelessWidget {

  var commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length>0 &&SocialCubit.get(context).socialUserModel!=null,
            builder: (context) {
            return SingleChildScrollView (
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8),
                    elevation: 10,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=1060&t=st=1659093226~exp=1659093826~hmac=1b151c683744b16e8fc7990f8adc4f935dfbe93dc0db10d2255525d055ef30cf'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate withe frinds',),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context, index) => SizedBox(height: 10,) ,
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            );
            },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
   Widget  buildPostItem(PostModel model,context,index){

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      elevation: 5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:NetworkImage('${model.image}'),

                    ),
                    SizedBox(width: 20,),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.name}',
                            ),
                            Text(
                              'Augast 17, 2002 at 11:02 pm',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(width: 15,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,size: 16,),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  '${model.text}',
                ),
                SizedBox(height: 12,),
                if(model.postImage!='')
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 420,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:  NetworkImage('${model.postImage}'),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 20,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5,),

                              Text(
                                //'${SocialCubit.get(context).getPostCommentNumber(SocialCubit.get(context).postId[index])}',
                                'comments',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                        },
                      ),
                    ),


                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:NetworkImage('${SocialCubit.get(context).socialUserModel!.image}'),

                            ),
                            SizedBox(width: 5,),
                            Text(
                              'write a comment ....',
                              style: TextStyle(
                                fontSize: 13
                                ,
                              ),
                            ),

                          ],
                        ),
                        onTap: (){
                          NavigateTo(context, CommentScreen(index: index,postId: SocialCubit.get(context).postId[index],));
                        },
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                'Like',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                          },
                        ),
                      ),
                      onTap: (){},
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Upload,
                              size: 20,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'Share',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
