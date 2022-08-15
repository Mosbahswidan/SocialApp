import 'package:flutter/material.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../login/login_screen.dart';
import '../login/login_screen.dart';

class onBording{
  final String title;
  final String body;
  final String images;
  onBording({required this.body,required this.images,required this.title});
}

class onBordingScreen extends StatelessWidget {
  List<onBording> bording=[
    onBording(body: 'screen body1', images: 'images/onbording1.jpg', title: 'screen title 1'),
    onBording(body: 'screen body2', images: 'images/onbording22.jpg', title: 'screen title 2'),
    onBording(body: 'screen body3', images: 'images/onbording3.jpg', title: 'screen title 3'),
  ];
  var pageControol=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageControol,
                itemBuilder: (context,index)=>Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Image(image: AssetImage(bording[index].images),)),
                    SizedBox(height: 25,),
                    Text(
                      bording[index].title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text(
                      bording[index].body,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
                itemCount: 3,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageControol,
                    count: bording.length,
                  effect: WormEffect(
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
                    if(value){
                      NavigateTo(context, login_screen());
                    }
                  });
                },child: Icon(Icons.arrow_forward_ios),
                backgroundColor: Colors.purple,)
              ],
            ),
          ],
        ),
      ),

    );
  }
}
