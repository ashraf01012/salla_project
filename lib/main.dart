import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_app/cubit/shop_cubit.dart';
import 'package:salla/layout/shop_app/shop_layout.dart';
import 'package:salla/modules/shop_app/login/login_screen_cubit/login_cubit.dart';
import 'package:salla/modules/shop_app/login/shop_login_screen.dart';
import 'package:salla/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:salla/shared/bloc_observer.dart';
import 'package:salla/shared/components/constans.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';

  if (token != '') {
    widget = ShopLayout();
  } else if (onBoarding == false) {
    widget = const OnBoardingScreen();
  } else {
    widget = ShopLoginScreen();
  }
  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

// class app extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LogCubit()..LogIn,
//       child: MaterialApp(
//         home: LogScreen(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit()..userLogIn,
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
