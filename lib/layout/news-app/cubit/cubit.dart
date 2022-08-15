import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/news-app/cubit/states.dart';
import '../../../modules/news_app/bussiness/bussiness.dart';
import '../../../modules/news_app/sicnce/sicnce.dart';
import '../../../modules/news_app/sports/sports.dart';
import '../../../sahred/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<AppStatenews> {
  NewsCubit() :super(AppIntealnewsState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    BussinessScreen(),
    SportsScreen(),
    SinceScreen(),

  ];
  List<BottomNavigationBarItem> bottomNavItem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void ChangeNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getSports();
    } else if (currentIndex == 2) {
      getScience();
    }
    emit(AppBottomNavnewsState());
  }

  List<dynamic> bussiness = [];
  List<dynamic> Sports = [];
  List<dynamic> Science = [];
  List<dynamic> Search = [];

  void getBussiness() {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      bussiness = value.data['articles'];
      emit(AppNewsGetDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppNewsGetDataErrorState(error.toString()));
    });
  }

  void getSports() {
    if (Sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        Sports = value.data['articles'];
        emit(AppSportsGetDataState());
      }).catchError((error) {
        print(error.toString());
        emit(AppSportsGetDataErrorState(error.toString()));
      });
    }
    else {
      emit(AppSportsGetDataState());
    }
  }

  void getScience() {
    if (Science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        Science = value.data['articles'];
        emit(AppScinceGetDataState());
      }).catchError((error) {
        print(error.toString());
        emit(AppScinceGetDataErrorState(error.toString()));
      });
    }

    else {
      emit(AppScinceGetDataState());
    }
  }

  void getSearch(String value) {

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      Search = value.data['articles'];
      emit(AppSearchGetDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppSearchGetDataErrorState(error.toString()));
    });
  }
}