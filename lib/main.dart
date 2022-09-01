import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/azkar_app/azkar_layout/azkar_cubit/azkar_cubit.dart';
import 'package:khwass_app/azkar_app/azkar_layout/azkar_layout.dart';
import 'package:khwass_app/layout/news_app/cubit_newsapp/status.dart';
import 'package:khwass_app/layout/news_app/news_layout.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_cubit.dart';
import 'package:khwass_app/layout/shop_app/shop_layout_app.dart';
import 'package:khwass_app/layout/todo_app/todoAppLayOut.dart';
import 'package:khwass_app/modules/shopping_app/boarding_screen.dart';
import 'package:khwass_app/network/local/cache_helper.dart';

import 'package:khwass_app/network/remote/dio_helper.dart';
import 'package:khwass_app/shaerd/blocoserver/blocObserver.dart';
import 'package:khwass_app/styles/themes.dart';


import 'layout/news_app/cubit_newsapp/cubit.dart';
import 'modules/shopping_app/login_shop/login_screen.dart';







void main()async
{
  Widget widget;
  bool onBoarding;
  String token;
  if(onBoarding!=null)
    {
      if(token!=null)widget=ShopLayOutApp();
      else widget = ShopAppLogin();
    }else
      {
        widget = BoardingShoppingApp();
      }

  BlocOverrides.runZoned(
        () {


          runApp(MyApp(widget));
        // DioHelper.init();
    },
    blocObserver: MyBlocObserver(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');
  print('onBoarding $onBoarding');

}

class MyApp extends StatelessWidget {

  final Widget startWidget;


  MyApp(this.startWidget);



  @override
  Widget build(BuildContext context) {

        return MultiBlocProvider(
          providers:
          [
            BlocProvider(
                create:(context)=>ShopCubit()..getHomeData()..getShopCategory()..getProfile()..getFavorites(),

            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            darkTheme: darkTheme,





            home:startWidget ,
          ),
        );


  }
}

