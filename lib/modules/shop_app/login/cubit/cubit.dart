import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/shop_app/login_model.dart';
import 'package:proj1/modules/shop_app/login/cubit/states.dart';
import 'package:proj1/sahred/network/remote/dio_helper.dart';

import '../../../../sahred/network/endoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginIntial());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  bool isPassword=true;
   static ShopLoginModel? loginModel;
void userLogin({
  required String email,
  required String password,
}){
  emit(ShopLoginLoading());
  DioHelper.postData(
      url: Login,
      data: {
        'email':email,
        'password':password,
      },).then((value){
        print(value.data);
        loginModel=ShopLoginModel.fromJason(value.data);
        emit(ShopLoginSucsses(loginModel!));
  }).catchError((error){
    emit(ShopLoginError(error.toString()));
  });
}
void ChangepasswordSecure(){
  isPassword=!isPassword;
  emit(ShopLoginChangeSecure());
}

}