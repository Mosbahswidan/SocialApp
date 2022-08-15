import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/social-app/social_layout.dart';
import 'package:proj1/modules/social-app/social-login-screen/cubit/cubit.dart';
import 'package:proj1/modules/social-app/social-login-screen/cubit/states.dart';
import 'package:proj1/sahred/network/local/cash_helper.dart';

import '../../../sahred/component/component.dart';
import '../social-register/social-register.dart';


class SocialLogin extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControler=TextEditingController();
  var passwordControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginSucsses){
            CacheHelper.saveData(key: 'uId', value:state.uId).then((value){
               navigateAndFinish(context, SocialLayout());
            });
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
                              SocialLoginCubit.get(context).ChangepasswordSecure();
                            },
                            isPass: SocialLoginCubit.get(context).isPassword,
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
                          condition: state is! SocialLoginLoading,
                          builder: (context)=>defultButton(width: double.infinity, background: Colors.blue, text: 'login', function: (){
                            if(formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).userLogin(email: emailControler.text, password: passwordControler.text);
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
                                 NavigateTo(context, SocialRegister());
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
          );
        },
      ),
    );
  }
}
