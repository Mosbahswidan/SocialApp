import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/layout/shop_app/shop.dart';
import 'package:proj1/modules/shop_app/login/cubit/cubit.dart';
import 'package:proj1/modules/shop_app/login/cubit/states.dart';
import 'package:proj1/sahred/component/constant.dart';
import 'package:proj1/sahred/network/local/cash_helper.dart';

import '../../../sahred/component/component.dart';
import '../register/shop_login_register.dart';

class login_screen extends StatelessWidget {

var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var  passwordControler=TextEditingController();
    var  emailControler=TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucsses){
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
        builder: (context,state)=>Scaffold(
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
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 38,
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
                            ShopLoginCubit.get(context).ChangepasswordSecure();
                          },
                          isPass: ShopLoginCubit.get(context).isPassword,
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
                      ),
                      SizedBox(height: 25,),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoading,
                        builder: (context)=>defultButton(width: double.infinity, background: Colors.blue, text: 'login', function: (){
                         if(formKey.currentState!.validate()){
                           ShopLoginCubit.get(context).userLogin(email: emailControler.text, password: passwordControler.text);
                         }
                        }),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'dont have an account?',
                            style: TextStyle(
                              fontSize:16,
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              NavigateTo(context, ShopRegister());
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
