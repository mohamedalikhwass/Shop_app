import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_status.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/cubit_login/cubit.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/cubit_login/states.dart';

import '../../layout/shop_app/cubit_shop/shop_cubit.dart';
import '../../models/shop_model/shop_catogrise_model.dart';

class ShopCategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener:(context,state){} ,
      builder: (context,state)
      {
        var cubit =ShopCubit.get(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>buildCategoryItems(cubit.shopCategoryModel.data.data[index]) ,
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            itemCount: cubit.shopCategoryModel.data.data.length,
        );
      },
    );
  }

  Widget buildCategoryItems(ShopCategoryDataOfDataModel model)
  {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image(
              height: 130,
              width: 130,
              image: NetworkImage(model.image),
          ),
          SizedBox(width: 15,),
          Text(
            model.name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          )
        ],
      ),
    );
  }
}
