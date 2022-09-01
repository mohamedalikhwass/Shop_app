import 'package:khwass_app/models/shop_model/shop_login_model.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ShopLoginLoadingState extends ShopAppStates{}

class ShopLoginSuccessState extends ShopAppStates
{
  final ShopLoginModel shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginErrorState extends ShopAppStates
{
  final String error;
  ShopLoginErrorState(this.error);
}


class ChangeIconPassword extends ShopAppStates{}