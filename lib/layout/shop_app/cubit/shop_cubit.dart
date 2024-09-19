import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/categories_model.dart';
import 'package:salla/models/shop_app/change_favorites_model.dart';
import 'package:salla/models/shop_app/favorites_model.dart';
import 'package:salla/models/shop_app/home_model.dart';
import 'package:salla/models/shop_app/login_model.dart';
import 'package:salla/modules/shop_app/categories/categories_screen.dart';
import 'package:salla/modules/shop_app/favorites/Favorites_screen.dart';
import 'package:salla/modules/shop_app/products/products_screen.dart';
import 'package:salla/modules/shop_app/settings/settings_screen.dart';
import 'package:salla/shared/components/constans.dart';
import 'package:salla/shared/network/end_points.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    print(token);
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token ?? '', // Handle possible null token
    ).then((value) {
      if (value.data != null) {
        homeModel = HomeModel.fromJson(value.data);
        emit(ShopSuccessHomeDataState(homeModel!));
      } else {
        emit(ShopErrorHomeDataState());
      }
    }).catchError((error) {
      print('Error getting home data: $error');
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      if (value.data != null) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ShopSuccessCategoriesState());
      } else {
        emit(ShopErrorCategoriesState());
      }
    }).catchError((error) {
      print('Error getting categories: $error');
      emit(ShopErrorCategoriesState());
    });
  }

  Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    final currentStatus = favorites[productId] ?? false;
    favorites[productId] = !currentStatus;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token ?? '', // Handle possible null token
    ).then((value) {
      if (value.data != null) {
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        if (changeFavoritesModel?.status == true) {
          getFavorites();
          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
        } else {
          favorites[productId] = currentStatus;
          emit(ShopErrorChangeFavoritesState());
        }
      } else {
        favorites[productId] = currentStatus;
        emit(ShopErrorChangeFavoritesState());
      }
    }).catchError((error) {
      print('Error changing favorites: $error');
      favorites[productId] = currentStatus;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token ?? '', // Handle possible null token
    ).then((value) {
      if (value.data != null) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        emit(ShopSuccessGetFavoritesState());
      } else {
        emit(ShopErrorGetFavoritesState());
      }
    }).catchError((error) {
      print('Error getting favorites: $error');
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token ?? '', // Handle possible null token
    ).then((value) {
      if (value.data != null) {
        userModel = ShopLoginModel.fromJson(json: value.data);
        emit(ShopSuccessUserDataState(userModel!));
      } else {
        emit(ShopErrorUserDataState());
      }
    }).catchError((error) {
      print('Error getting user data: $error');
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token ?? '', // Handle possible null token
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      if (value.data != null) {
        userModel = ShopLoginModel.fromJson(json: value.data);
        emit(ShopSuccessUpdateUserState(userModel!));
      } else {
        emit(ShopErrorUpdateUserState());
      }
    }).catchError((error) {
      print('Error updating user data: $error');
      emit(ShopErrorUpdateUserState());
    });
  }
}
