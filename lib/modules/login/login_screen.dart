
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sahred/component/component.dart';

class Login_screen extends   StatefulWidget {
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  var emailControler =TextEditingController();

  var passwordControler =TextEditingController();

  var formKey=GlobalKey<FormState>();
  var isPassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight:FontWeight.bold ,
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
                        return 'mosbah swidan';
                      }
                      return null;
                    },
                    prefix: Icons.email,



                  ),
                  SizedBox(
                    height: 20,
                  ),

                  defaulFormField(
                    labelText: 'pass',
                    prefix: Icons.lock,
                    suffix: Icons.remove_red_eye,
                    type: TextInputType.emailAddress,
                      isPass: isPassword,
                      suffixPress:(){
                      setState(() {
                        isPassword=!isPassword;
                      });
                    },
                    control: passwordControler,
                    vlaidd: (value){
                      if(value.isEmpty){
                        return 'pass mosbah';
                      }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defultButton(
                    background: Colors.blue,
                    text: 'logg',
                    width: double.infinity,
                    function:(){
                      if(formKey.currentState!.validate()){
                        print("hi");
                      }
                    },
                    isUpperCase: false,
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
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>Rigester_screen()));

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
  }
}