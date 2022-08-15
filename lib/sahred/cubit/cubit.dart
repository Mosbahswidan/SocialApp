

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proj1/sahred/cubit/states.dart';
import 'package:proj1/sahred/network/local/cash_helper.dart';

import 'package:sqflite/sqflite.dart';



import '../../modules/todo_app/archive_task/archive_task.dart';
import '../../modules/todo_app/done_task/done_task.dart';
import '../../modules/todo_app/new_task/new_task.dart';
import '../network/local/cash_helper.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppIntealStatees());
  static AppCubit get(context)=> BlocProvider.of(context);
  List<Map> newtasks=[];
  List<Map> archivetasks=[];
  List<Map> donetasks=[];
  List<Widget> screens=[
    newTask(),
    DoneTask(),
    ArchiveTask(),
  ];
  List<String> titles=[
    'new Task',
    'Done Task',
    'Archive Task',
  ];
  var indexx=0;

  void changeIndex(int index){
    indexx=index;
    emit(AppChangeBottomNavState());
  }
  late Database database;

  void CreateDataBase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database,version)async{
        print('dataBase created');
        await database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time Text, status TEXT)');
      } ,
      onOpen:(database){
        getDataFromDatabase(database);

        } ,
    ).then((value){
      database=value;
      emit(AppCreateDataBase());
    });
  }
   insertDataBase({
    required String title,
    required String date,
    required String time,
  })async {
     await database.transaction((txn)async{
      txn.rawInsert('INSERT INTO tasks( title, date, time, status) VALUES( "$title", "$date", "$time", "new")').then((value){
        print('$value added sucssesful');
        emit(AppInsertToDataaBase());
        getDataFromDatabase(database);
      }).catchError((error){
        print('the error is ${error.toString()}');
      });
      return null;
    } );
  }

  void getDataFromDatabase(database){
    newtasks=[];
    donetasks=[];
    archivetasks=[];
    database.rawQuery('SELECT * FROM tasks').then((value){
      value.forEach((element) {
        if(element['status']=='new'){
          newtasks.add(element);
        }
        else if(element['status']=='done'){
          donetasks.add(element);
        }
        else{
          archivetasks.add(element);
        }
      });
      emit(AppGeFromDataBase());
    });

  }


  void UpdateDataBase({
  required String status,
    required int id,
}) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value){
          getDataFromDatabase(database);
          emit(AppUpdateDataaBase());

    });
  }

  void DeleteDatabase({required int id}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDataaBase());
    });

  }
  bool isDark=false;
  void changeMood({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeMood());

    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMood());
      });
    }
  }
}