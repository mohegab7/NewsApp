import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Shop_app/Home_model.dart';
import 'package:flutter_application_1/moduels/shop_app/cateogires/cateogires.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/moduels/shop_app/favorites/favorites.dart';
import 'package:flutter_application_1/moduels/shop_app/products/products.dart';
import 'package:flutter_application_1/moduels/shop_app/settings/settings.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context) => BlocProvider.of(context);
  int current_index = 0;
  List<Widget> bottamScreens = [
    ProductsScreen(),
    CateogiresScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottam(int index) {
    current_index = index;
    emit(ShopChangeBottomStates());
  }

  late HomeModel homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    dio_helper
        .getData(
      url: HOME,
    )
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel.data.banners[0].image);
      print(homeModel.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorHomeDataState());
    });
  }
}
