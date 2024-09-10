import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cupit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/shop_layout.dart';
import 'package:flutter_application_1/moduels/person/typeadabetor.dart';
import 'package:flutter_application_1/moduels/shop_app/login/login_shop.dart';
import 'package:flutter_application_1/moduels/shop_app/on_boarding/on_boarding_screen.dart';
// import 'package:flutter_application_1/moduels/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_application_1/shared/bloc_ofserver.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';

import 'shared/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(Person_Type_Adaberor());
  Bloc.observer = MyBlocObserver();
  dio_helper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  if (onBoarding = true) {
    if (token == true) {
      widget = ShopLayout();
    } else
      widget = LoginShop_Screen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    StartWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget StartWidget;
  MyApp({
    required this.isDark,
    required this.StartWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewCuipt()
            ..GetBusiness()
            ..GetSports()
            ..GetScience(),
        ),
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              )),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: ShopLayout(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
