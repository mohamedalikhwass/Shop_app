import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit_shop/shop_cubit.dart';
import '../../layout/shop_app/cubit_shop/shop_status.dart';
import '../../models/shop_model/shop_favorites_model.dart';
import '../../models/shop_model/shop_get_favorites_model.dart';

class ShopFavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStatus>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition:  state is ShopSuccessGetFavorites,//FavoritesModel != null,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel.data.data[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem( model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage(model.product.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product.discount != 0)
                      Text(
                        model.product.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                      ),
                      color: ShopCubit.get(context).favorite[model.id] ? Colors.amber :Colors.grey,
                      // disabledColor:  Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}