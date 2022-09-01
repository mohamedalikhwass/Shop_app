import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/models/shop_model/shop_login_model.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/cubit_login/states.dart';
import 'package:khwass_app/network/end_points.dart';
import 'package:khwass_app/network/remote/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates>
{
  ShopAppCubit() : super(ShopAppInitialState());
  static ShopAppCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel loginModel;


  bool isPassword=true;
  IconData iconShowPassword=Icons.remove_red_eye;

  void changePasswordIcon()
  {
    isPassword = !isPassword;
    iconShowPassword=isPassword ?Icons.remove_red_eye:Icons.visibility_off;
    emit(ChangeIconPassword());
  }


  void loginUser(
  {
  @required String email,
  @required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.posDate(
        url: Login,
        data:
        {
          'email': email , 'password': password,
        } ,
    ).then((value)
    {
      loginModel =ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));

    }).catchError((error)
    {
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });
  }


}