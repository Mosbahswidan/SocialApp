import 'package:proj1/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginIntial extends ShopLoginStates{}
class ShopLoginSucsses extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSucsses(this.loginModel);
}
class ShopLoginError extends ShopLoginStates{
  final String error;
  ShopLoginError(this.error);
}
class ShopLoginLoading extends ShopLoginStates{}
class ShopLoginChangeSecure extends ShopLoginStates{}