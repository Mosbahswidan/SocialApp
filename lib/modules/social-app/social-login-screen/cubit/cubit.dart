import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/shop_app/login_model.dart';
import 'package:proj1/modules/shop_app/login/cubit/states.dart';
import 'package:proj1/modules/social-app/social-login-screen/cubit/states.dart';
import 'package:proj1/sahred/network/remote/dio_helper.dart';

import '../../../../sahred/network/endoints.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() :super(SocialLoginIntial());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  //static ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoading());
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
        print(value.user!.email);
        emit(SocialLoginSucsses(value.user!.uid));
      }).catchError((error){
        emit(SocialLoginError(error.toString()));
      });
    }



void ChangepasswordSecure(){
  isPassword=!isPassword;
  emit(SocialLoginChangeSecure());
}

}