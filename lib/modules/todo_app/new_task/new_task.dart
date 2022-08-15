import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/sahred/cubit/cubit.dart';
import 'package:proj1/sahred/cubit/states.dart';

import '../../../sahred/component/component.dart';



class newTask extends StatelessWidget {
  const newTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit,AppStates>(

      listener: (context, state) { },
      builder: (context,state){
        var list=AppCubit.get(context).newtasks;
        return ListView.separated(itemBuilder:(context, index) => BuildtaskItem(list[index],context), separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ), itemCount: list.length);
      },
    );
  }
}
