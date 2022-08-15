import 'package:proj1/models/shop_app/login_model.dart';

abstract class ShopStates{}
  class ShopIntialState extends ShopStates{}
  class ShopChangeNavBarState extends ShopStates{}
  class ShopLoadingHomeDataState extends ShopStates{}
  class ShopSuccesHomeDataState extends ShopStates{}
  class ShopErrorHomeDataState extends ShopStates{}
  class ShopSuccesCategoriesDataState extends ShopStates{}
  class ShopErrorCategoriesDataState extends ShopStates{}
  class ShopChangeFavouriteSuccses extends ShopStates{}
  class ShopChangeFavouriteError extends ShopStates{}
  class ShopChangeFavouriteIconColor extends ShopStates{}
class ShopGetFavouriteSuccses extends ShopStates{}
class ShopGetprofileSuccses extends ShopStates{
  final ShopLoginModel shopLoginModel;
  ShopGetprofileSuccses(this.shopLoginModel);
}
class ShopGetprofileError extends ShopStates{}
class ShopLoadingGetFavourite extends ShopStates{}
class ShopGetFavouriteError extends ShopStates{}