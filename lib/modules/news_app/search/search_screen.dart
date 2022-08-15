import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/news-app/cubit/cubit.dart';
import 'package:proj1/layout/news-app/cubit/states.dart';
import 'package:proj1/sahred/component/component.dart';

class searchScreen extends StatelessWidget {
  var searchControoler=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStatenews>(
     listener: (context, state) {

     },
      builder: (context,state){
        var list=NewsCubit.get(context).Search;
       return Scaffold(
         appBar: AppBar(),

         body:Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: defaulFormField(
                 control: searchControoler,
                 onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                 },
                 labelText:'Search',
                 type: TextInputType.text,
                 vlaidd: (String value){
                   if(value.isEmpty){
                     return 'the field must not be empty';
                   }
                   else {
                     return null;
                   }
                 },
                 prefix: Icons.search,
               ),
             ),
             Expanded(
               child: ConditionalBuilder(
                 builder: (context)=>ListView.separated(
                   itemBuilder:(context, index) => BuildNewsItem(NewsCubit.get(context).Search[index],context),
                   separatorBuilder:(context,index){
                     return Container(
                       width: double.infinity,
                       height: 1,
                       color: Colors.grey[300],
                     );
                   },
                   itemCount:10 ,),
                 condition: list.isNotEmpty,
                 fallback: (context)=>Container(),
               ),
             ),
           ],
         ) ,
       );
      },
    );
  }
}
