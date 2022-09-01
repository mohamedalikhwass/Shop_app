class ShopHomeModel
{
  bool status;
  ShopHomeDataModel data;

  ShopHomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = ShopHomeDataModel.fromJson(json['data']);
  }
}

class ShopHomeDataModel
{
  List<ShopBannerModel> banners = [];
  List<ShopProductModel> products = [];

  ShopHomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(ShopBannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ShopProductModel.fromJson(element));
    });
  }
}

class ShopBannerModel
{
  int id;
  String image;

  ShopBannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ShopProductModel
{
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ShopProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}