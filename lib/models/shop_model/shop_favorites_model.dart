class ShopFavoritesModel
{
  bool status;
  String message;

  ShopFavoritesModel.fromJson(Map <String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}