import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/models/shop_model/shop_login_model.dart';
import 'package:khwass_app/modules/shopping_app/shop_regester/cubit_regester/states.dart';
import 'package:khwass_app/network/end_points.dart';
import 'package:khwass_app/network/remote/dio_helper.dart';

class  ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel shopRegisterModel;


  bool isPassword=true;
  IconData iconShowPassword=Icons.remove_red_eye;

  void changePasswordIcon()
  {
    isPassword = !isPassword;
    iconShowPassword=isPassword ?Icons.remove_red_eye:Icons.visibility_off;
    emit(ChangeRegisterIconPassword());
  }


  void registerUser(
  {

    @required String name,
    @required String phone,
    @required String email,
    @required String password,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.posDate(
        url: REGISTER,
        data:
        {
          'name': name ,
          'phone': phone ,
          'email': email ,
          'password': password,
        } ,
    ).then((value)
    {
      shopRegisterModel =ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopRegisterModel));

    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error.toString()));
      print(error.toString());
    });
  }


}