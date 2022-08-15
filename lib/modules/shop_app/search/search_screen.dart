import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/shop_app/search/cubit/cubit.dart';
import 'package:proj1/modules/shop_app/search/cubit/states.dart';
import 'package:proj1/sahred/component/component.dart';

import '../../../layout/shop_app/cubit/cubit.dart';

class searchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var seachController=TextEditingController();
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaulFormField(
                        control: seachController,
                        labelText: 'search',
                        type: TextInputType.text,
                        vlaidd: (String value){
                          if(value.isEmpty){
                            print('Search must not be empty');
                          }
                        },
                        prefix: Icons.search,
                      onSubmit: (String text){
                          SearchCubit.get(context).Search(text);
                      },
                       ontap: (){},
                      onChange: (x){
                          return null;
                      },

                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingStates)
                      LinearProgressIndicator(),
                    SizedBox(height: 13,),
                    if(state is SearchSuccesslStates)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildFavItem(SearchCubit.get(context).searchModel!.data!.data![index],context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
