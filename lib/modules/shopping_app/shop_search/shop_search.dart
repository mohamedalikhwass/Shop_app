import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_cubit.dart';
import 'package:khwass_app/modules/shopping_app/shop_search/shop_search-cubit/shop_search_cubit.dart';
import 'package:khwass_app/modules/shopping_app/shop_search/shop_search-cubit/shop_search_states.dart';

import '../../../models/shop_model/shop_get_favorites_model.dart';
import '../../../shaerd/components/components.dart';

class ShopSearchScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(state is ShopLoadingSearchStates)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextForm(
                          control: searchController,
                          icon: Icons.search,
                          labelText: 'Search',
                          validat: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please Enter Text To Search';
                            }
                            return null;
                          },
                        onFieldSubmitted: (String text)
                        {
                          ShopSearchCubit.get(context).getShopSearch(text);
                        }

                      ),
                      if(state is ShopSuccessSearchStates)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildShopProductItem(ShopSearchCubit.get(context).searchModel.data.data[index], context),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsetsDirectional.only(start: 16.0),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          itemCount: ShopSearchCubit.get(context).searchModel.data.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        },

      ),
    );

  }
}


