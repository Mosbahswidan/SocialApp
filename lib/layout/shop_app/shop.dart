import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/shop_app/cubit/states.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/network/local/cash_helper.dart';

import '../../modules/shop_app/login/login_screen.dart';
import '../../modules/shop_app/search/search_screen.dart';
import 'cubit/cubit.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
      },
      builder: (context,index) {
        var cubit=ShopCubit.get(context);
       return Scaffold(
          appBar: AppBar(
            title: Text('The old man'),
            actions: [
              IconButton(onPressed: (){
                NavigateTo(context, searchScreen());
              }, icon: Icon(Icons.search),),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           onTap: (index){
             cubit.ShopChangeNavBar(index);
           },
           currentIndex: cubit.currentIndex,
           items: [
             BottomNavigationBarItem(
               icon: Icon(Icons.home),
               label: 'Home',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.apps),
               label: 'Categories',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.favorite),
               label: 'Favorite',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.settings),
               label: 'Settings',
             ),
           ],
         ),

        );
      }
    );
  }
}
