import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/news-app/cubit/cubit.dart';
import 'package:proj1/layout/news-app/cubit/states.dart';
import 'package:proj1/sahred/cubit/cubit.dart';
import 'package:proj1/sahred/network/remote/dio_helper.dart';


import '../../modules/news_app/search/search_screen.dart';
import '../../sahred/component/component.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStatenews>(
      listener: (context, state) {
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'News App'
            ),
            actions: [
              IconButton(onPressed: (){
                return NavigateTo(context,searchScreen());
              }, icon: Icon(Icons.search),color: Colors.black,),
              IconButton(onPressed: (){
                AppCubit.get(context).changeMood();
              }, icon: Icon(Icons.brightness_4_outlined),color: Colors.black,),
            ],
          ),

          body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: NewsCubit.get(context).bottomNavItem,
            currentIndex: NewsCubit.get(context).currentIndex,
            onTap: (index){
              NewsCubit.get(context).ChangeNavBar(index);
            },
          ),
        );
      },
    );
  }
}
