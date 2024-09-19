part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class ShopLoginLoadingState extends LoginState {}

class ShopLoginInitialState extends LoginState {}

class ShopLoginSuccessState extends LoginState {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends LoginState {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends LoginState {}
