import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cupit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cupit/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sport_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCuipt, NewStates>(
        builder: (context, state) {
          var list = NewCuipt.get(context).Sports;
          return articleBuilder(list,context);
        },
        listener: (context, state) {});
  }
}
