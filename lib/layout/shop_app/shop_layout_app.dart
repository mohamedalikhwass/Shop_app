import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_cubit.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_status.dart';
import 'package:khwass_app/modules/shopping_app/shop_search/shop_search.dart';

import '../../shaerd/components/components.dart';

class ShopLayOutApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= ShopCubit.get(context);
        return Scaffold(

            appBar: AppBar(
              title: Text('KHWASS'),
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigatorTo(context,ShopSearchScreen());
                  }
                  , icon: Icon(Icons.search),),
              ]
              ,
            ),
            bottomNavigationBar: BottomNavigationBar
              (
              currentIndex: cubit.cureintIndex,
                onTap: (int index)
                {
                  cubit.changeBottomNav(index);
                },




                items: [
            BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
            BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                  ),
            BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                  ),
            BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                    )


              ],
            ),
          body: cubit.bottomScreens[cubit.cureintIndex],
          );
      }
        );

      }
    }
