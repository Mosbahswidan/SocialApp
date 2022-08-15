import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/shop_app/cubit/states.dart';
import 'package:proj1/sahred/component/component.dart';

import '../../../layout/shop_app/cubit/cubit.dart';

class settingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var model=ShopCubit.get(context).shopLoginModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).shopLoginModel!=null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaulFormField(
                    control: nameController,
                    labelText: 'Name',
                    type: TextInputType.text,
                    vlaidd: (String value){
                      if(value.isEmpty){
                        print('this field must not be empty');
                      }
                    },
                    prefix: Icons.person),
                SizedBox(height: 15,),
                defaulFormField(
                    control: emailController,
                    labelText: 'Email',
                    type: TextInputType.text,
                    vlaidd: (String value){
                      if(value.isEmpty){
                        print('this field must not be empty');
                      }
                    },
                    prefix: Icons.email),
                SizedBox(height: 15,),
                defaulFormField(
                    control: phoneController,
                    labelText: 'Phone',
                    type: TextInputType.text,
                    vlaidd: (String value){
                      if(value.isEmpty){
                        print('this field must not be empty');
                      }
                    },
                    prefix: Icons.phone_android),
                SizedBox(height: 15,),
                defultButton(width: double.infinity, background:Colors.orange , text: 'LOGOUT', function:(){
                  SignOut(context);
                }),
              ],
            ),
          ),
          fallback:(context)=>CircularProgressIndicator(),
        ) ;
      },
    );
  }
}
