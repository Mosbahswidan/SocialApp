import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/layout/social-app/cubit/states.dart';
import 'package:proj1/models/social-app/comment_model.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

class CommentScreen extends StatelessWidget {
  var CommentController=TextEditingController();
  int? index;
  String?postId;
  CommentScreen({
    this.index,
    this.postId
});


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getPostComments(postId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            List<CommentModel>model=SocialCubit.get(context).comment;
            return Scaffold(
              appBar: AppBar(
                leading: Icon(
                    IconBroken.Arrow___Left_2
                ),
                title: Text('Comments'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          ConditionalBuilder(
                            condition: SocialCubit.get(context).comment!=null,
                            builder: (context) => ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                SocialCubit.get(context).comment=[];
                                return buildCommentItem(context,model[index]);
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 20,),
                              itemCount:model.length,
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: CommentController,
                        decoration: InputDecoration(
                          hintText: 'What is on your mind....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(onPressed: (){
                      SocialCubit.get(context).coommentPost(
                        SocialCubit.get(context).postId[index!],
                        CommentController.text,
                      );
                    }, icon: Icon(IconBroken.Send,color: Colors.blue,)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

    Widget buildCommentItem(context,CommentModel m) {
    return  Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage:NetworkImage('${m.image}'),

        ),
        SizedBox(width: 7,),
        Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${m.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${m.comment}'),
                  ),
                  SizedBox(height: 10,),
                ],

              ),
            ],
          ),
          decoration: BoxDecoration(
            color:Colors.grey[300],
            borderRadius: BorderRadius.circular(10),

          ),
        ),
      ],
    );
  }
}
