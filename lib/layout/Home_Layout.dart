import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj1/sahred/cubit/cubit.dart';
import 'package:proj1/sahred/cubit/states.dart';


import 'package:sqflite/sqflite.dart';

import '../sahred/component/component.dart';
import '../sahred/component/constant.dart';
class HomeLayout extends StatelessWidget {
  @override
  var titleControl=TextEditingController();
  var dateControl=TextEditingController();
  var dateeeControl=TextEditingController();
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var Formkey=GlobalKey<FormState>();
  bool isBottomSheet=false;

  @override

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..CreateDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is AppInsertToDataaBase){
            Navigator.pop(context);
          }
        } ,
        builder: (context,states){
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                AppCubit.get(context).titles[AppCubit.get(context).indexx],
              ),
            ),
            body: AppCubit.get(context).screens[AppCubit.get(context).indexx],
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                if(isBottomSheet){
                  if(Formkey.currentState!.validate()) {
                    AppCubit.get(context).insertDataBase(
                      title: titleControl.text,
                      date: dateeeControl.text,
                      time: dateControl.text,

                    );
                  }
                }
                else{
                  scaffoldKey.currentState!.showBottomSheet((context) => Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Form(

                      key: Formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaulFormField(
                            type: TextInputType.text,
                            control: titleControl,
                            labelText: 'task title',
                            vlaidd: (String value){
                              if(value.isEmpty){
                                return 'the field must not be empty';
                              }
                              return null;

                            },
                            prefix: Icons.title,
                            ontap: (){},


                          ),
                          SizedBox(height: 10,),
                          defaulFormField(
                            type: TextInputType.datetime,
                            control: dateControl,
                            labelText: 'time',
                            vlaidd: (String value){
                              if(value.isEmpty){
                                return 'the field must not be empty';
                              }
                              return null;

                            },
                            prefix: Icons.watch_later_outlined,
                            ontap: (){
                              showTimePicker(context: context, initialTime:TimeOfDay.now()).then((value) {
                                dateControl.text=value!.format(context).toString();
                              });
                            },

                          ),
                          SizedBox(height: 10,),
                          defaulFormField(
                            type: TextInputType.datetime,
                            control: dateeeControl,
                            labelText: 'Date',
                            vlaidd: (String value){
                              if(value.isEmpty){
                                return 'the field must not be empty';
                              }
                              return null;

                            },
                            prefix: Icons.calendar_today,
                            ontap:(){
                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2023,12,05)).then((value){
                                dateeeControl.text=DateFormat.yMMMEd().format(value!);
                              });
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                    elevation: 20,
                  ).closed.then((value){
                    isBottomSheet = false;

                  });
                  isBottomSheet=true;
                }


              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).indexx,
              onTap: (index){
                // setState(() {
                //   indexx=index;
                // });
               AppCubit.get(context).changeIndex(index);

              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archive',
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}

