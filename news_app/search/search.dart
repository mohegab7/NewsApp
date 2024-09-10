import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cupit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cupit/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  var SearchControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCuipt, NewStates>(
      builder: (context, state) {
        var list = NewCuipt.get(context).Search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: SearchControll,
                  onType: (value) {
                    NewCuipt.get(context).GetSearch(value);
                  },
                  type: TextInputType.text,
                  hint: 'search',
                  prefix: Icons.search,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'search is empty';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
