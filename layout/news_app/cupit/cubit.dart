import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cupit/states.dart';
import 'package:flutter_application_1/moduels/news_app/business/business.dart';
import 'package:flutter_application_1/moduels/news_app/science/science.dart';
import 'package:flutter_application_1/moduels/news_app/sports/sports.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCuipt extends Cubit<NewStates> {
  NewCuipt() : super(intinalstate());
  static NewCuipt get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomitems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Bussiness',
    ),
    const BottomNavigationBarItem(
      icon: const Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // )
  ];

  List<Widget> screens = [
    Business_Screen(),
    Sport_Screen(),
    Science_Screen(),
  ];
  List<String> titles = [
    'Business',
    'Sport',
    'Science',
    'Settings',
  ];

  void changeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1) {
      GetSports();
    }
    if (index == 2) {
      GetScience();
    }
    emit(NewBotomNavState());
  }

  List<dynamic> business = [];
  void GetBusiness() {
    emit(NewGetBussinessloadingState());
    dio_helper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
    }).then((value) {
      // print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Sports = [];
  void GetSports() {
    emit(NewGetSportsloadingState());
    if (Sports.length == 0) {
      dio_helper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sport',
        'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        // print(value.data.toString());
        Sports = value.data['articles'];
        print(Sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> Science = [];
  void GetScience() {
    emit(NewGetScienceloadingState());
    if (Science.length == 0) {
      dio_helper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        // print(value.data.toString());
        Science = value.data['articles'];
        print(Science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> Search = [];
  void GetSearch(String value) {
    emit(NewGetSearchloadingState());

    dio_helper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apikey': '165315a648d34ffcb3da962d64484283'
    }).then((value) {
      // print(value.data.toString());
      Search = value.data['articles'];
      print(Search[0]['title']);
      emit(NewsGetSeacrchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetSearchErrorState(error.toString()));
    });
  }
}
