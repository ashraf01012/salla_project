part of 'shop_cubit.dart';

abstract class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {
  ShopSuccessHomeDataState(HomeModel homeModel);
}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopChangeFavoritesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopState {}

class ShopLoadingGetFavoritesState extends ShopState {}

class ShopSuccessGetFavoritesState extends ShopState {}

class ShopErrorGetFavoritesState extends ShopState {}

class ShopLoadingUserDataState extends ShopState {}

class ShopSuccessUserDataState extends ShopState {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopState {}

class ShopLoadingUpdateUserState extends ShopState {}

class ShopSuccessUpdateUserState extends ShopState {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopState {}
