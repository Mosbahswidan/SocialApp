import 'package:proj1/models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterIntial extends ShopRegisterStates{}
class ShopRegisterSucsses extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSucsses(this.loginModel);



}
class ShopRegisterError extends ShopRegisterStates{
  final String error;

  ShopRegisterError(this.error);
}
class ShopRegisterLoading extends ShopRegisterStates{}
class ShopRegisterSecure extends ShopRegisterStates{}