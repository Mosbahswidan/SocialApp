import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj1/modules/bmi_result/Bmi_res.dart';

class BmiScreen extends StatefulWidget {


  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale=true;
  double height=180;
  double weight=60;
  double age=18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Bmi calculator'),
      ) ,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale=true;
                        });
                      },
                      child: Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Image(
                               image: AssetImage('images/male.png'),
                               height: 100,
                             ),
                            SizedBox(height: 15,),
                            Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale?Colors.blue:Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale=false;
                        });
                      },
                      child: Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Image(
                               image: AssetImage('images/female.png'),
                               height: 100,
                             ),
                             SizedBox(height: 15,),
                            Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale?Colors.grey:Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HIEGHT',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'cm',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Slider(
                      value: height,
                      max: 220,
                      min: 110,
                      onChanged: (value){
                        setState(() {
                          height=value;
                        });

                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           'WEIGHT',
                           style: TextStyle(
                             fontSize: 25,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         Text(
                           '${weight.round()}',
                           style: TextStyle(
                             fontSize: 35,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             FloatingActionButton(
                               onPressed: (){
                                 setState(() {
                                   weight--;
                                 });
                               },
                               mini: true,
                               child: Icon(Icons.remove),
                             ),
                             FloatingActionButton(
                               onPressed: (){
                                 setState(() {
                                   weight++;
                                 });
                               },
                               mini: true,
                               child: Icon(Icons.add),
                             ),
                           ],
                         ),
                       ],

                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           'Age',
                           style: TextStyle(
                             fontSize: 25,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         Text(
                           '${age.round()}',
                           style: TextStyle(
                             fontSize: 35,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             FloatingActionButton(
                               onPressed: (){
                                 setState(() {
                                   age--;
                                 });
                               },
                               mini: true,
                               child: Icon(Icons.remove),
                             ),
                             FloatingActionButton(
                               onPressed: (){
                                 setState(() {
                                   age++;
                                 });
                               },
                               mini: true,
                               child: Icon(Icons.add),
                             ),
                           ],
                         ),
                       ],

                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.red,
            height:45,
            child: MaterialButton(
              onPressed: (){
                double result=weight/pow(height/100, 2);
                Navigator.push(
                    context,
                  MaterialPageRoute(builder:(context)=>BmiResult(
                    result: result,
                    age: age,
                    isMale: isMale,
                  ),),);

              },
              child: Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
