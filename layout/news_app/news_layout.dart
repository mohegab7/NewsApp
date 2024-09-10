import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cupit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cupit/states.dart';
import 'package:flutter_application_1/moduels/news_app/search/search.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class New_layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCuipt, NewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewCuipt.get(context);
        return Scaffold(
          appBar: AppBar(
            //backgroundColor: HexColor['333739'],
            title: Text(cubit.titles[cubit.currentindex]),
            actions: [
              IconButton(
                onPressed: () {Navigateto(context,Search(),);},
                icon: Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_rounded))
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          // backgroundColor: HexColor('333739'),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomitems,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
