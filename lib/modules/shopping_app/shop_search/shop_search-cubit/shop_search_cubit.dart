import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/models/shop_model/shop_search_model.dart';
import 'package:khwass_app/modules/shopping_app/shop_search/shop_search-cubit/shop_search_states.dart';
import 'package:khwass_app/network/remote/dio_helper.dart';
import 'package:khwass_app/shaerd/components/constantes.dart';

import '../../../../network/end_points.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>
{
  ShopSearchCubit():super (ShopInitialSearchStates());

  static ShopSearchCubit get(context)=>BlocProvider.of(context);

  SearchModel searchModel;
  void getShopSearch(String text)
  {
    emit(ShopLoadingSearchStates());
    DioHelper.posDate(
        url: Search,
        data: {
          'text':text,
        },
        token: token,
        ).then((value)
    {
      searchModel =SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchStates());
    }).catchError((error){
      emit(ShopErrorSearchStates());
    });
  }

}

