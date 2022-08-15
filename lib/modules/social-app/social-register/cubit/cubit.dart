import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/social-app/social_user_mdel.dart';
import 'package:proj1/modules/shop_app/register/cubit/states.dart';
import 'package:proj1/modules/social-app/social-register/cubit/states.dart';

import 'package:proj1/sahred/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../sahred/network/endoints.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(SocialRegisterIntial());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  bool isPassword=true;
   //static ShopLoginModel? loginModel;
void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
}){
  emit(SocialRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user!.email);
      userCreate(email: email, password: password, name: name, phone: phone, uId: value.user!.uid);
    }).catchError((error){
      emit(SocialRegisterError(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uId,

}){
  SocialUserModel model=SocialUserModel(
    email: email,
    name: name,
    password: password,
    phone: phone,
      bio: 'write your bio',
      uId: uId,
    image: 'https://scontent.fgza9-1.fna.fbcdn.net/v/t39.30808-6/274473534_1826232434236112_8259770904627916354_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=54sGVE-3L2MAX-J3S55&_nc_ht=scontent.fgza9-1.fna&oh=00_AT80LYRPrZlkswD6-t2872Pm1yE-Vz-A2GI3x_R2qYGbxQ&oe=62F08743',
    isEmailVerfied: false,
    cover: 'https://scontent.fgza9-1.fna.fbcdn.net/v/t39.30808-6/281902501_1888421634683858_2025493768940747538_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=6e1MUoSCNP0AX-YXH7_&tn=NjjJI3SN7h2Zjqf9&_nc_ht=scontent.fgza9-1.fna&oh=00_AT-22rcYDSYtoYF8HGMdLrUAUmCXpa9l8kBDrs9NvDy4-Q&oe=62F2282A',
    token: FirebaseMessaging.instance.getToken().toString(),
  );

   FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
     emit(SocialCreateUserSucsses());
   }).catchError((error){
     emit(SocialCreateUserError(error.toString()));
   });

  }

void ChangepasswordSecure(){
  isPassword=!isPassword;
  emit(SocialRegisterSecure());
}

}