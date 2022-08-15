import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:proj1/layout/shop_app/cubit/cubit.dart';
import 'package:proj1/layout/social-app/cubit/cubit.dart';
import 'package:proj1/modules/bmi_result/Bmi_res.dart';
import 'package:proj1/modules/bmi/bmi_screen.dart';
import 'package:proj1/modules/counter/cubit/cubit.dart';
import 'package:proj1/modules/users/user_screen.dart';
import 'package:proj1/sahred/bloc_observ.dart';
import 'package:proj1/sahred/component/component.dart';
import 'package:proj1/sahred/component/constant.dart';
import 'package:proj1/sahred/cubit/cubit.dart';
import 'package:proj1/sahred/cubit/states.dart';
import 'package:proj1/sahred/network/local/cash_helper.dart';
import 'package:proj1/sahred/network/remote/dio_helper.dart';
import 'package:proj1/sahred/styles/themes.dart';
import 'layout/Home_Layout.dart';
import 'layout/news-app/cubit/cubit.dart';
import 'layout/news-app/news_layout.dart';
import 'layout/shop_app/shop.dart';
import 'layout/social-app/social_layout.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/qustion/qustion.dart';

import 'modules/shop_app/login/login_screen.dart';
import 'modules/shop_app/onbording/onbording_screen.dart';
import 'modules/social-app/social-login-screen/social_login_screen.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

print(message.data.toString());

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  var tokeen =await FirebaseMessaging.instance.getToken();
  print(tokeen);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToastt(text: 'confirmed', state: ToastState.SUCSSES);

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToastt(text: 'confirmed', state: ToastState.SUCSSES);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  late Widget widget;
  DioHelper.init();
   await CacheHelper.init();
   //bool ?isDark=CacheHelper.getData(key: 'isDark');
   bool? onboard=CacheHelper.getData(key: 'onBoarding');
   //token=CacheHelper.getData(key: 'token');
  uId=CacheHelper.getData(key: 'uId');
   //print(token);

   // if(onboard!=null){
   // if(token!=null){
   //   widget=ShopLayout();
   // }
   // else{
   //   widget=login_screen();
   // }
   // }else{
   //   widget=onBordingScreen();
   // }
   //print(onboard);
     if(uId!=null){
       widget=SocialLayout();
     }
     else{
       widget=SocialLogin();
     }

  BlocOverrides.runZoned(

        () { runApp( MuApp(
      startWidget: widget,
    ));},
    blocObserver: MyBlocObserver(),
  );

}
class MuApp extends StatelessWidget {
  @override
  final Widget? startWidget;

  MuApp({required this.startWidget});

  var index = 0;
  void pressed() {
    index++;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts()),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getcategoriesData()..getfavouritesData()..getprofileData()),
        BlocProvider(create: (context)=>AppCubit()),
        BlocProvider(create: (context)=>NewsCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:light,
            darkTheme:dark,
            // themeMode: AppCubit
            //     .get(context)
            //     .isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}






