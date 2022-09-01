import '../../../models/shop_model/shop_login_model.dart';

abstract class ShopStatus{}

class ShopInitialState extends ShopStatus{}

class ShopChangeBottomBar extends ShopStatus{}

class ShopLoadingHomeDate extends ShopStatus{}

class ShopSuccessHomeDate extends ShopStatus{}

class ShopErrorHomeDate extends ShopStatus{}

class ShopSuccessCategoryDate extends ShopStatus{}

class ShopErrorCategoryDate extends ShopStatus{}

class ShopSuccessChangeFavorites extends ShopStatus{}

class ShopErrorChangeFavorites extends ShopStatus{}

class ShopChangeFavorites extends ShopStatus{}

class ShopLoadingGetFavorites extends ShopStatus{}

class ShopSuccessGetFavorites extends ShopStatus{}

class ShopErrorGetFavorites extends ShopStatus{}

class ShopLoadingGetProfile extends ShopStatus{}

class ShopSuccessGetProfile extends ShopStatus{
  final ShopLoginModel shopGetProfileUModel;

  ShopSuccessGetProfile(this. shopGetProfileUModel);
}

class ShopErrorGetProfile extends ShopStatus{}

class ShopLoadingUpdateProfile extends ShopStatus{}

class ShopSuccessUpdateProfile extends ShopStatus{

  final ShopLoginModel shopProfileUpdateModel;

  ShopSuccessUpdateProfile(this.shopProfileUpdateModel);
}

class ShopErrorUpdateProfile extends ShopStatus{}


