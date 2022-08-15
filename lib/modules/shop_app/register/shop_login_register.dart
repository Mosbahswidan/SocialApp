import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/shop_app/register/cubit/cubit.dart';
import 'package:proj1/modules/shop_app/register/cubit/states.dart';

import '../../../layout/shop_app/shop.dart';
import '../../../sahred/component/component.dart';
import '../../../sahred/component/constant.dart';
import '../../../sahred/network/local/cash_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';

class ShopRegister extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControler=TextEditingController();
  var passwordControler=TextEditingController();
  var phoneControler=TextEditingController();
  var nameControler=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {

          if (state is ShopRegisterSucsses){
            if(state.loginModel.status==true){
              print(state.loginModel.data!.name);
              showToastt(text:state.loginModel.message.toString(),state:ToastState.SUCSSES);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value){
                token=state.loginModel.data!.token;
                NavigateTo(context, ShopLayout());
              });

            }
            else{
              print(state.loginModel.message);
              showToastt(text:state.loginModel.message.toString(),state:ToastState.ERROR);


            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        defaulFormField(
                          control: nameControler,
                          labelText: 'Name',
                          type: TextInputType.text,
                          vlaidd:(value){
                            if(value.isEmpty){
                              return 'the name must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          onChange: (s){
                            return null;
                          },
                          ontap: (){
                            return null;
                          },
                          onSubmit: (z){},

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaulFormField(
                          control: emailControler,
                          labelText: 'email',
                          type: TextInputType.emailAddress,

                          vlaidd:(value){
                            if(value.isEmpty){
                              return 'the email must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.email,
                          onChange: (s){
                            return null;
                          },
                          ontap: (){
                            return null;
                          },
                          onSubmit: (z){},

                        ),
                        SizedBox(
                          height: 20,
                        ),

                        defaulFormField(
                            labelText: 'password',
                            prefix: Icons.lock,
                            suffix: Icons.remove_red_eye,
                            type: TextInputType.visiblePassword,
                            suffixPress:(){
                              ShopRegisterCubit.get(context).ChangepasswordSecure();
                            },
                            isPass: ShopRegisterCubit.get(context).isPassword,
                            onChange: (s){
                              return null;
                            },
                            ontap: (){
                              return null;
                            },
                            onSubmit: (z){},
                            control: passwordControler,
                            vlaidd: (value){
                              if(value.isEmpty){
                                return 'the password must not be empty';
                              }
                              return null;
                            }
                        ),SizedBox(
                          height: 20,
                        ),
                        defaulFormField(
                          control: phoneControler,
                          labelText: 'phone',
                          type: TextInputType.phone,

                          vlaidd:(value){
                            if(value.isEmpty){
                              return 'the phone must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                          onChange: (s){
                            return null;
                          },
                          ontap: (){
                            return null;
                          },
                          onSubmit: (z){},
                        ),
                        SizedBox(height: 25,),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoading ,
                          builder: (context)=>defultButton(width: double.infinity, background: Colors.blue, text: 'register', function: (){
                            if(formKey.currentState!.validate()){
                              ShopRegisterCubit.get(context).userRegister(email: emailControler.text, password: passwordControler.text, name: nameControler.text, phone: phoneControler.text);
                            }
                          }),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
