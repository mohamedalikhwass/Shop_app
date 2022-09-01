
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_status.dart';
import 'package:khwass_app/models/shop_model/shop_favorites_model.dart';
import 'package:khwass_app/modules/shopping_app/shop_catogres.dart';
import 'package:khwass_app/modules/shopping_app/shop_favoret.dart';
import 'package:khwass_app/modules/shopping_app/shop_home.dart';
import 'package:khwass_app/modules/shopping_app/shop_settengs.dart';
import 'package:khwass_app/network/end_points.dart';
import 'package:khwass_app/shaerd/components/constantes.dart';

import '../../../models/shop_model/shop_catogrise_model.dart';
import '../../../models/shop_model/shop_get_favorites_model.dart';
import '../../../models/shop_model/shop_home_model.dart';
import '../../../models/shop_model/shop_login_model.dart';
import '../../../network/remote/dio_helper.dart';

class ShopCubit extends Cubit <ShopStatus>
{
  ShopCubit() : super (ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int cureintIndex =0;

  List<Widget> bottomScreens=
  [
    ShopHomeScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottomNav(int index)
  {
    cureintIndex=index;
    emit(ShopChangeBottomBar());
  }

  ShopHomeModel shopHomeModel;
  Map < int , bool> favorite={};

  void getHomeData()

  {
    emit(ShopLoadingHomeDate());
    DioHelper.getDate(url: Home,token: token)
        .then((value) {
          shopHomeModel = ShopHomeModel.fromJson(value.data);
          // print(shopHomeModel.toString());
          // print(shopHomeModel.data.banners[0].image);

          shopHomeModel.data.products.forEach((element)
          {
            favorite.addAll({
              element.id :element.inFavorites,
            });
          });
          print(favorite.toString());
          emit(ShopSuccessHomeDate());


    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDate());

    });
  }


  ShopCategoryModel shopCategoryModel;

  void getShopCategory()

  {
    DioHelper.getDate(
        url: Category,
        token: token
    )
        .then((value) {
      shopCategoryModel = ShopCategoryModel.fromJson(value.data);


      emit(ShopSuccessCategoryDate());

    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoryDate());

    });
  }

  ShopFavoritesModel shopFavoritesModel;

  void changeFavorites(int productId)
  {
    favorite[productId]=!favorite[productId];
    emit(ShopChangeFavorites());
    DioHelper.posDate(
        url: FAVORITES,
        data: {'product_id':productId},
       token: token,
    ).then((value)
    {
      shopFavoritesModel=ShopFavoritesModel.fromJson(value.data);
      if(!shopFavoritesModel.status)
        {
          favorite[productId]=!favorite[productId];
        }else{ getFavorites();}

      emit(ShopSuccessChangeFavorites());
    }).catchError((error)
    {
      favorite[productId]=!favorite[productId];
      emit(ShopErrorChangeFavorites());
    });
  }


  FavoritesModel favoritesModel ;


  void getFavorites()
  {
    emit(ShopLoadingGetFavorites());

    DioHelper.getDate(
        url: FAVORITES,
        token: token,
    ).then((value)
    {

      favoritesModel = FavoritesModel.fromJson(value.data);


      emit(ShopSuccessGetFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavorites());
    });
  }


  ShopLoginModel profileModel;

  void getProfile()
  {
    emit(ShopLoadingGetProfile());

    DioHelper.getDate(
        url: PROFILE,
        token: token
    ).then((value)
    {
      profileModel = ShopLoginModel.fromJson(value.data);
      //  printFullText(value.data.toString());

      emit(ShopSuccessGetProfile(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfile());
    });
  }


  ShopLoginModel updateProfileModel;

  void updateProfile(
  {
    @required String name,
    @required String email,
    @required String phone,
  }
      )
  {
    emit(ShopLoadingUpdateProfile());

    DioHelper.putDate(
        url: UpdateProfile,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        },
      token: token,
    ).then((value)
    {
      updateProfileModel = ShopLoginModel.fromJson(value.data);
      print(value.data.toString());

      emit(ShopSuccessUpdateProfile(updateProfileModel));

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfile());
    });
  }

}