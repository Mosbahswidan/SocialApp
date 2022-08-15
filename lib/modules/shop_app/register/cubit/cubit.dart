import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/shop_app/register/cubit/states.dart';

import 'package:proj1/sahred/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../sahred/network/endoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(ShopRegisterIntial());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  bool isPassword=true;
   static ShopLoginModel? loginModel;
void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
}){
  emit(ShopRegisterLoading());
  DioHelper.postData(
      url: REGISTER,
      data: {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
      },).then((value){
        print(value.data);
        loginModel=ShopLoginModel.fromJason(value.data);
        emit(ShopRegisterSucsses(loginModel!));
  }).catchError((error){
    emit(ShopRegisterError(error.toString()));
  });
}
void ChangepasswordSecure(){
  isPassword=!isPassword;
  emit(ShopRegisterSecure());
}

}