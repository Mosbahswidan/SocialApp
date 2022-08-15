import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/shop_app/cubit/states.dart';
import 'package:proj1/models/shop_app/categories_model.dart';
import 'package:proj1/models/shop_app/favourties_model.dart';
import 'package:proj1/models/shop_app/home_model.dart';
import 'package:proj1/sahred/network/endoints.dart';
import 'package:proj1/sahred/network/remote/dio_helper.dart';

import '../../../models/shop_app/change_favourits_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/news_app/search/search_screen.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favourite/favourite_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/setting_screen.dart';
import '../../../sahred/component/constant.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopIntialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
     int currentIndex=0;

     List<Widget> Screens=[
       productsScreen(),
       categoriesScreen(),
       favouriteScreen(),
       settingsScreen(),
  ];
  void ShopChangeNavBar(int index) {
    currentIndex=index;
    emit(ShopChangeNavBarState());
  }
  HomeModel? homeModel;
  Map<int ,bool>favourits={};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home,token: token,).then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourits.addAll({
          element.id!:element.inFavorites!
        }
        );
      });
      print(favourits.toString());
      emit(ShopSuccesHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  CategoriesModel? categoriesModel;

  void getcategoriesData(){
    DioHelper.getData(url: Get_Categories,token: token,).then((value){
      categoriesModel=CategoriesModel.fromJason(value.data);
      emit(ShopSuccesCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }
  ChangeFavouritsModel? changeFavouritsModel;
  void changeFavourits(int productId){
    favourits[productId]=!favourits[productId]!;
    emit(ShopChangeFavouriteIconColor());
    DioHelper.postData(
        url: FAVOURITS,
        data:{ 'product_id': productId },
         //token:token,
    ).then((value) {
      changeFavouritsModel=ChangeFavouritsModel.fromJson(value.data);
      print(value.data);
      if(!changeFavouritsModel!.status!) {
        favourits[productId]=!favourits[productId]!;
      }
      else{
        getfavouritesData();
      }
      emit(ShopChangeFavouriteSuccses());
    }).catchError((error){
      favourits[productId]=!favourits[productId]!;
      emit(ShopChangeFavouriteError());
    });
  }
  FavoriteModel?favoriteModel;

  void getfavouritesData(){
    emit(ShopLoadingGetFavourite());
    DioHelper.getData(url: FAVOURITS,token: token,).then((value){
      favoriteModel=FavoriteModel.fromJson(value.data);
      emit(ShopGetFavouriteSuccses());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetFavouriteError());
    });
  }


  ShopLoginModel?shopLoginModel;

  void getprofileData(){
    DioHelper.getData(url: PROFOLE,token: token,).then((value){
      shopLoginModel=ShopLoginModel.fromJason(value.data);
      print(shopLoginModel!.data!.name);
      emit(ShopGetprofileSuccses(shopLoginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetprofileError());
    });
  }

}