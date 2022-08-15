

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/sahred/cubit/cubit.dart';
import 'package:proj1/sahred/styles/icon_broken.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/shop_app/favourties_model.dart';
import '../../modules/shop_app/login/login_screen.dart';
import '../../modules/webview/web_view_screen.dart';
import '../network/local/cash_helper.dart';

Widget defultButton({
   double? width,
  required Color background,
  required String text,
  bool isUpperCase=true,
  required Function function,

})=> Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed:(){
      return function();
    },
    child: Text(isUpperCase?text.toUpperCase():text,
      style: TextStyle(
        color:Colors.white,
      ),
    ),
  ),
);


Widget defaulFormField({
  required TextEditingController control,
  required String labelText,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
   Function? ontap,
   Function? onChange,
   required Function vlaidd,
  required IconData prefix,
  Function? suffixPress,
  bool isPass=false,
  IconData? suffix,
})=>TextFormField(

  controller: control,
  obscureText: isPass?true:false,
  keyboardType:type ,
  onFieldSubmitted: onSubmit,
  decoration:InputDecoration(
    labelText: labelText,
    prefixIcon:Icon(
      prefix,
    ),

    suffixIcon:suffix!=null? IconButton(
      onPressed: (){
       return suffixPress!();
      },
      icon: Icon(
        suffix,

      ),
    ):null,
    border:OutlineInputBorder() ,
  ) ,
  validator: (s){
    return vlaidd(s);
  },
  onTap: (){
    return ontap!();
  },
  onChanged:(s){
    return onChange!(s);
  } ,
);

Widget BuildtaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 35,
          child:Text('${model['time']}'),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${model['title']}',
                style:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ) ,

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),



            ],

          ),

        ),

        SizedBox(width: 20,),

        IconButton(

          onPressed: (){

            AppCubit.get(context).UpdateDataBase(status: 'done', id: model['id']);

          },

          icon: Icon(Icons.check_circle),

        ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).UpdateDataBase(status: 'archive', id: model['id']);

          },

          icon: Icon(Icons.archive),

        ),

      ],

    ),

  ),
  onDismissed: (direction){
  AppCubit.get(context).DeleteDatabase(id: model['id']);
  },
);





Widget BuildNewsItem(article, BuildContext context)=>InkWell(
  onTap: (){
    NavigateTo(context, Webview(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120,

          width: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10,),

              image: DecorationImage(

                image: NetworkImage('${article['urlToImage']}'),



                fit: BoxFit.cover,

              ),



          ),

        ),

        SizedBox(width: 17,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment:CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight: FontWeight.w600,

                    ),

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      fontSize: 20,

                      fontWeight: FontWeight.w600,

                      color: Colors.grey

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);


void NavigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder:(context)=>widget),);


void showToastt({required String text,required ToastState state})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choosToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState{SUCSSES,ERROR,WARNING}
Color   choosToastColor(ToastState state){
  Color color;
   switch(state){
     case ToastState.SUCSSES:
       color= Colors.green;
       break;
     case ToastState.ERROR:
       color= Colors.red;
       break;
     case ToastState.WARNING:
       color= Colors.yellow;
       break;
   }
   return color;
  }

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );


void SignOut(context){
  CacheHelper.clearData(key: 'token').then((value){
    navigateAndFinish(context, login_screen());
  });
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget buildFavItem( model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
              image: NetworkImage(model.image!),
              width: 120.0,
              height: 120.0,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavourits(model.id!);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget defaultAppbar(
  {
  required BuildContext context,
    String? title,
    List<Widget>? actions,
  }
)=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left
    ),
  ),
  title: Text(
    title!,
  ),
  actions: actions,
);






