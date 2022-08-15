import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj1/layout/social-app/cubit/states.dart';
import 'package:proj1/layout/social-app/social_layout.dart';
import 'package:proj1/models/social-app/comment_model.dart';
import 'package:proj1/models/social-app/message_model.dart';
import 'package:proj1/models/social-app/post_model.dart';
import 'package:proj1/models/social-app/social_user_mdel.dart';
import 'package:proj1/models/users/user_model.dart';
import 'package:proj1/modules/social-app/comments_screen/comments_screen.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/network/remote/dio_helper.dart';
import '../../../modules/social-app/newpost/new-post.dart';
import '../../../sahred/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:proj1/modules/social-app/chats/chats_screen.dart';
import 'package:proj1/modules/social-app/feeds/feeds_screen.dart';
import 'package:proj1/modules/social-app/settings/settings_screen.dart';
import 'package:proj1/modules/social-app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super (SocialInitialState());
  //hi mosbah
  static SocialCubit get(context)=>BlocProvider.of(context);
  Map<String, int> postsLikesbymap = ({});
  Map<String, int> postsCommentsbymap = ({});
  List<String> mylikedpostslist = [];
  List<PostModel> myposts = [];
  int currentIndex=0;
  List<int>indeeeex=[];
  List<Widget>Screens=[
    FeedsScreen(),
  ChatsScreen(),
    newPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles=[
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings'
  ];
  SocialUserModel? socialUserModel;
  void getUserData(){
    emit(SocialGetUserLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get(
    ).then((value){
      socialUserModel =SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccsess());
    }).catchError((error){
      emit(SocialGetUserError(error.toString()));
    });
  }

  void changeBottomNavIndex(int index){
    if(index==1)
      getUsers();
    if(index==2)
      emit(SocialAddPostState());
    else{
      currentIndex=index;
      emit(SocialChangeBottomNav());
    }

  }
   File? profileimage;
  Future<void> getProfileImage()async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image !=null){
      profileimage=File(image.path);
      emit(SocialProfileImagePickedSuccess());
    }else{
      print('no image selected');
      emit(SocialProfileImagePickedError());
    }
  }


  File? coverimage;
  Future<void> getcoverImage()async{
    final coverrimage=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(coverrimage !=null){
      coverimage=File(coverrimage.path);
      emit(SocialCoverImagePickedSuccess());
    }else{
      print('no image selected');
      emit(SocialCoverImagePickedError());
    }
  }
  String coverImageUrl='';

  void uploadprofileImage({required String name,
    required String phone,
    required String bio,}){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
    .putFile(profileimage!).then((value)
    {
      value.ref.getDownloadURL().then((value){
        print(value);
        updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error){print(error.toString());});
    }).catchError((error){print(error.toString());});





  }

  void uploadcoverImage({required String name,
    required String phone,
    required String bio,}){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!).then((value)
    {
      value.ref.getDownloadURL().then((value){
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){print(error.toString());});
    }).catchError((error){print(error.toString());});





  }

// void updateUserImages({
//   required String name,
//   required String phone,
//   required String bio,
// }){
//     if(coverimage !=null){
//       uploadcoverImage();
//     }
//     else if(profileimage!=null)
//     {
//       uploadprofileImage();
//     }else if(coverimage!=null && profileimage!=null){
//
//     }else
//     {
//       updateUser(bio: bio,name: name,phone: phone);
//     }
//
//
// }




void updateUser({
  required String name,
  required String phone,
  required String bio,
  String? cover,
  String? image,
}){
  SocialUserModel model=SocialUserModel(
    name: name,
    phone: phone,
    bio: bio,
    email: socialUserModel!.email,
    uId: uId,
    password:socialUserModel!.password,
    cover:cover?? socialUserModel!.cover,
    image: image??socialUserModel!.image,



  );
  FirebaseFirestore.instance.collection('users').doc(uId).update(model.toMap()).
  then((value)
  {
    getUserData();
  }
  ).
  catchError((error)
  {
    emit(SocialUpdateUserError());
  }
  );
}



  void UploadPostPost({
    required String text,

  }){
    emit(SocialCreatePostLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value)
    {
      value.ref.getDownloadURL().then((value){
        print(value);
        CreatePost(
          text: text,
          postimage: value,
        );
      }).catchError((error)
      {
        print(error.toString());
        emit(SocialCreatePostError());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialCreatePostError());
    });





  }

  File? postImage;
  Future<void> getpostImage()async{
    final posttimage=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(posttimage !=null){
      postImage=File(posttimage.path);
      emit(SocialpostImagePickedSuccess());
    }else{
      print('no image selected');
      emit(SocialpostImagePickedError());
    }
  }

  void CreatePost({
    required String text,
    String? postimage,
  }){
    emit(SocialCreatePostLoading());
    PostModel model=PostModel(
      name: socialUserModel!.name,
      uId: uId,
      image:socialUserModel!.image,
      text: text,
      postImage: postimage??'',



    );
    FirebaseFirestore.instance.collection('posts').add(model.toMap()).
    then((value)
    {
      emit(SocialCreatePostSucces());
    }
    ).
    catchError((error)
    {
      emit(SocialCreatePostError());
    }
    );
  }
  List<PostModel> posts=[];
  List<String> postId=[];
  List<int> likes=[];
  List<int> comments=[];
  List<CommentModel> commentt=[];


  var datacomment=FirebaseFirestore.instance.collection('posts').get();

  Future<void> getPosts() async {
     FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {

           value.docs.forEach((element)
           {
             element.reference
                 .collection('Like')
                 .get()
                 .then((value){

               likes.add(value.docs.length);
               posts.add(PostModel.fromJson(element.data()));
               postId.add(element.id);
               emit((SocialLikePostSuccsess()));

            //    posts.add(PostModel.fromJson(element.data()));
            // postId.add(element.id);
              // print(likes);
               //emit(SocialGetCommentSuccsess());
               // posts.add(PostModel.fromJson(element.data()));
               // postId.add(element.id);
             })
                 .catchError((error){
               print(error.toString());
             });


          }

          );


           //getComment();
    }
    )
        .catchError((error){
          emit(SocialGetPostError(error.toString()));
    });


  }

  void likePost(String postId){
    FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
        .collection('Like')
        .doc(socialUserModel!.uId)
        .set({
      'like':true,
    })
        .then((value){
          emit(SocialLikePostSuccsess());

    })
        .catchError((error){
          emit(SocialLikePostError(error.toString()));
    });

  }

  void coommentPost(String postId,String commeent){
    CommentModel modeel=CommentModel(
      comment: commeent,
      name: socialUserModel!.name,
      image: socialUserModel!.image,
      dateTime: DateTime.now().toString(),
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
       // .doc(socialUserModel!.uId)
        .add(modeel.toMap())
        .then((value){
          emit(SocialWrriteCommentSuccess());
          comment=[];
           getPostComments(postId);
    })
        .catchError((error){
          emit(SocialWrriteCommentError(error.toString()));
    });
  }

  // void getComment()async{
  //   await FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc()
  //       .collection('comments')
  //       .get()
  //       .then((value){
  //         value.docs.forEach((element) {
  //           commentt.add(CommentModel.fromJson(element.data()));
  //           emit(SocialGetCommentSuccsess());
  //           print(commentt.length);
  //         });
  //
  //   })
  //       .catchError((error){
  //
  //   });
  //      // await FirebaseFirestore.instance
  //      // .collection('posts')
  //      // .get()
  //      // .then((value)
  //      // {
  //      //   value.docs.forEach((element) {
  //      //     element.reference.collection('comments')
  //      //         .get()
  //      //         .then((value)
  //      //     {
  //      //       commentt.add(CommentModel.fromJson(element.data()));
  //      //       emit(SocialGetCommentSuccsess());
  //      //     }
  //      //     )
  //      //         .catchError((error){});
  //      //     element.reference
  //      //         .collection('comments')
  //      //         .get()
  //      //         .then((value) {
  //      //       comments.add(value.docs.length);
  //      //
  //      //     })
  //      //         .catchError((error){
  //      //       print(error.toString());
  //      //
  //      //     });
  //      //   });
  //      // }
  //      // )
  //      // .catchError((error){
  //      //   emit(SocialGetCommentError(error.toString()));
  //      // });
  // }

// void getComment()async{
//      await FirebaseFirestore.instance
//         .collection('posts')
//         .get()
//         .then((value) {
//           value.docs.forEach((element) {
//               element.reference
//                 .collection('comments')
//                 .get()
//                 .then((value) {
//                comments.add(value.docs.length);
//                print(value.docs.length);
//              // print(comments);
//               emit(SocialGetCommentSuccsess());
//
//             })
//                 .catchError((error){
//               print(error.toString());
//
//             });
//           }
//
//
//        );
//      })
//   .catchError((error){
//     emit(SocialGetCommentError(error.toString()));
//      });
//
//
// }



Future<void> getComment()async{
    FirebaseFirestore.instance
        .collection('posts')
        .get()
    .then((value){
      value.docs.forEach((element) {
        element.reference
            .collection('comments')
            .get().then((value)
        {
          comments.add(value.docs.length);

          emit(SocialGetCommentSuccsess());

        }
        )
            .catchError((error){
              print(error.toString());
        });

      }
      );

    })

    .catchError((error){
      emit(SocialGetCommentError(error.toString()));
    });

}

void GetCommentsss(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value){
          comments.add(value.docs.length);
    })
        .catchError((error){});

}


List<SocialUserModel> users=[];

  void getUsers(){
    if(users.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {

      value.docs.forEach((element)
      {
        if(element.data()['uId']!=socialUserModel!.uId)
        users.add(SocialUserModel.fromJson(element.data()));
      }
      );
      emit(SocialGetAllUserSuccsess());

    }
    )
        .catchError((error){
      emit(SocialGetAllUserError(error.toString()));
    });
  }



  void SendMessgae({
  required String reciverId,
    required String text,
    required int dateTime,
    String? ChatImage,
}){
    MessageModel model=MessageModel(
      text: text,
      senderId: socialUserModel!.uId,
      reciverId: reciverId,
      dateTime: dateTime,
      ChatImage: ChatImage,
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc(socialUserModel!.uId)
    .collection('chats')
    .doc(reciverId)
    .collection('message')
    .add(model.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccsess());
    }
    )
    .catchError((error){
      emit(SocialSendMessageError());
    });



    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(socialUserModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value)
    {
      //emit(SocialSendMessageSuccsess());
    }
    )
        .catchError((error){
      emit(SocialSendMessageError());
    });
  }
  late List<MessageModel> messages= [];
  List<Map<String,dynamic>>data=[];
  void  getMessages({required String reciverId}) {
     FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel!.uId)
        .collection('chats')
        .doc(reciverId)
    .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      //messages=[];
      messages=[];
      data=[];

       event.docs.forEach((element) {
         data.add(element.data());
          messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessageSuccsess());


    });

  }
  
  
  // int? getPostCommentNumber(postId){
  //     comments=[];
  //     FirebaseFirestore.instance
  //     .collection('posts')
  //     .doc(postId)
  //     .collection('comments')
  //     .get()
  //     .then((value){
  //       emit(SocialGetCommentSuccsess());
  //       return value.docs.length;
  //     })
  //     .catchError((error){
  //       emit(SocialGetCommentError(error.toString()));
  //     });
  //
  // }


   late List<CommentModel>comment=[];
  void getPostComments(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments').orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(comment);
          comment.add(CommentModel.fromJson(element.data()));
        emit(SocialGetCommentsSuccessState());

      });
    }).catchError((error){
      showToastt(state: ToastState.ERROR,text: error.toString());
    });

  }


   Future<void> SendNotification(SocialUserModel model,String title)async{
   await DioHelper.postData(url: 'https://fcm.googleapis.com/fcm/send',
        data: {
            "to":
            "${model.token}",
            "notification": {
              "title": title,
              "body":"Hidden message click to check",
              "sound":"default"
            },
            "android":{
              "priority":"HIGH",
              "notification":{
                "notification_priority": "PRIORITY_MAX",
                "sound":"default",
                "default_sound":true,
                "default_vibrate_timings":true,
                "default_light_settings":true
              }
            },
            "data": {
              "type":"order",
              "id":"87",
              "click_action":"FLUTTER_NOTIFICATION_CLICK"

            }


        });
  }

  File? chatImage;
  Future<void> getchatImage()async{
    final posttimage=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(posttimage !=null){
      chatImage=File(posttimage.path);
      emit(SocialchatImagePickedSuccess());
    }else{
      print('no image selected');
      emit(SocialchatImagePickedError());
    }
  }

  void deleteChatImage(){
    chatImage=null;
    emit(SocialDeleteChatImage());
  }

  void UploadChat({
    required String text,
    required String reciverId,
    required int dateTime,
    String? ChatImage,
    String?uiid

  }){
    emit(SocialCreatePostLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats').child(uiid.toString())
        .putFile(chatImage!).then((value)
    {
      value.ref.getDownloadURL().then((value){
        print(value);
        SendMessgae(reciverId: reciverId, text: text, dateTime: dateTime,ChatImage: value);

      }).catchError((error)
      {
        print(error.toString());
        emit(SocialCreatePostError());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialCreatePostError());
    });
}

  List<PostModel> Myposts=[];
  List<String> MypostId=[];

void getUserPost(String uid){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value){
          Myposts=[];
          MypostId=[];
          value.docs.forEach((element) {
            if(element.data()['uId']==uid){
              Myposts.add(PostModel.fromJson(element.data()));
              MypostId.add(element.id);
            }

          }

          );
          emit(SocialGetUserPostSuccess());
          print(Myposts.length);
    }).catchError((erroe){
      emit(SocialGetUserPostError());
    });
}
  }
