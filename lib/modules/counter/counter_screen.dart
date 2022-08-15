import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/counter/cubit/cubit.dart';
import 'package:proj1/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>CounerCubit(),
      child: BlocConsumer<CounerCubit,CounterStates>(
        listener: (context,state){},
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                     CounerCubit.get(context).minus();
                    },
                    child: Text(
                      'MINUS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: Text(
                      '${CounerCubit.get(context).counter}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      CounerCubit.get(context).plus();
                    },
                    child: Text(
                      'PLUS',
                    ),
                  ),

                ],
              ),
            ),
          );
        } ,
      ),
    );
  }
}
