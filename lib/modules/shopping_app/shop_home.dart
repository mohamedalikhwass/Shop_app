import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_cubit.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_status.dart';
import 'package:khwass_app/models/shop_model/shop_home_model.dart';

import '../../models/shop_model/shop_catogrise_model.dart';

class ShopHomeScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener: (context, state) {},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.shopHomeModel!=null && cubit.shopCategoryModel!=null,
            builder:(context)
            {
              return productBuilder(cubit.shopHomeModel,cubit.shopCategoryModel,context);
            },
            fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
      },
        );
  }

  Widget productBuilder(ShopHomeModel model,ShopCategoryModel shopCategoryModel,context)
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),

      child: Column(
       children: [
         CarouselSlider(
           items:
      [
             Image(
                 image: AssetImage('assets/images/m_1.png'),
                width: double.infinity,

            ),
             Image(
                image: AssetImage('assets/images/m_2.png'),
                width: double.infinity,

                ),
            Image(
                image: AssetImage('assets/images/m_3.png'),
                width: double.infinity,
                ),

  ],

            /* model.data.banners.map((e) => Image(
        image: NetworkImage('${e.image}'),
        fit: BoxFit.cover,
        width: double.infinity,
      ),).toList(),

             */



             options: CarouselOptions(
               autoPlay: true,
               height: 250.0,
               viewportFraction: 1.0,
               autoPlayAnimationDuration: Duration(seconds: 1,),
               initialPage: 0,


             )),
         SizedBox(height: 10,),
         Text(
           'Category',
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 25.0,
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Container(
             height: 100,
             child: ListView.separated(
               scrollDirection: Axis.horizontal ,
                 physics:BouncingScrollPhysics() ,
                 itemBuilder: (context,index)=>buildCategoryItems(shopCategoryModel.data.data[index]),
                 separatorBuilder:  (context,index)=>SizedBox(width: 8,),
                 itemCount: shopCategoryModel.data.data.length,
             ),
           ),
         ),
         SizedBox(height: 10,),
         Container(
             color: Colors.grey[300],
             child: SizedBox(height: 5,)),
         Text(
           'New Products',
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 25.0,
           ),
         ),
         Container(
           color: Colors.grey[300],
           child: GridView.count(
               crossAxisCount: 2,
             mainAxisSpacing: 1.0,
             crossAxisSpacing: 1.0,
             childAspectRatio: 1/1.6,
             shrinkWrap: true,
             padding:EdgeInsets.symmetric(horizontal: 7),
             physics: NeverScrollableScrollPhysics(),
             children: List.generate(
                 model.data.products.length,
                 ((index) =>productGridBuilder(model.data.products[index],context) )
             ),
           ),
         ),
       ],
      ),
    );
  }

  Widget productGridBuilder(ShopProductModel model,context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.white,
            child: Stack(
              children: [
                Image(
                  image: NetworkImage('${model.image}'),


                ),
                if(model.discount!=0)
                  Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      backgroundColor: Colors.red,
                      color: Colors.amber,
                      fontSize: 12,
                    ),
                  ),
                ),

              ],
            ),
          ),
          Text(

            model.name,
          style: TextStyle(
            height: 1.5,
            overflow: TextOverflow.ellipsis,
            fontSize: 14.0,

          ),
            maxLines: 2,



          ),
          Spacer(),
          Row(
            children: [
              Text(
                '${model.price.round()}',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 15,
                ),
              ),
              SizedBox(width: 5,),
              if(model.discount!=0)
                Text(

                '${model.oldPrice.round()}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize:12,
                  textBaseline: TextBaseline.ideographic,
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
    );
  }

  Widget buildCategoryItems(ShopCategoryDataOfDataModel model)
  {
    return  Stack(
      alignment: AlignmentDirectional. bottomCenter ,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
        ),
        Container(
          color: Colors.grey.withOpacity(.5),
          width: 100,
          child: Text(
            model.name,
            maxLines:1 ,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,


            ),
          ),
        )
      ],

    );
  }
}
