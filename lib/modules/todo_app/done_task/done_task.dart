import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sahred/component/component.dart';
import '../../../sahred/cubit/cubit.dart';
import '../../../sahred/cubit/states.dart';


class DoneTask extends StatelessWidget {
  const DoneTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(

      listener: (context, state) {
      },
      builder: (context,state){
        var list=AppCubit.get(context).donetasks;
        return ListView.separated(itemBuilder:(context, index) => BuildtaskItem(list[index],context), separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ), itemCount: list.length);
      },
    );
  }
}
