import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/counter/cubit/states.dart';

class CounerCubit extends Cubit<CounterStates>{
  int counter =0;
  CounerCubit():super(CounterInteal());

  static CounerCubit get(context) => BlocProvider.of(context);

  void minus(){
    counter--;
    emit(Counterminus());
  }
  void plus(){
    counter++;
    emit(Counterplus());
  }



}