import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/shop_app/search_model.dart';
import 'package:proj1/modules/shop_app/search/cubit/states.dart';
import 'package:proj1/sahred/component/constant.dart';
import 'package:proj1/sahred/network/endoints.dart';


import '../../../../sahred/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialStates());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchModel;
  void Search(String text){
    emit(SearchLoadingStates());
    // /DioHelper.postData(url:SEARCH,token: token, data: {
    //   'text':text,
    // }).then((value){
    //   searchModel=SearchModel.fromJson(value.data);
    //   emit(SearchSuccesslStates());
    // }).catchError((error){
    //   emit(SearchErrorStates());
    // });
  }

}