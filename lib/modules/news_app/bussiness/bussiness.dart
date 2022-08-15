import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/news-app/cubit/cubit.dart';
import 'package:proj1/layout/news-app/cubit/states.dart';

import '../../../sahred/component/component.dart';


class BussinessScreen extends StatelessWidget {
  const BussinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStatenews>(
      listener: (context, state) {
      },
      builder: (context,state)=>ConditionalBuilder(condition:NewsCubit.get(context).bussiness.length>0
          , builder:
          (context)=>ListView.separated( physics:BouncingScrollPhysics(),itemBuilder: (context, index) =>BuildNewsItem(NewsCubit.get(context).bussiness[index],context) , separatorBuilder:(context,index){
            return Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            );
          }, itemCount: 10),
          fallback:
          (context)=>Center(child: CircularProgressIndicator(),)),
    );
  }
}
