abstract class NewStates {}

class intinalstate extends NewStates {}

class NewBotomNavState extends NewStates {}

class NewGetBussinessloadingState extends NewStates {}

class NewsGetBusinessSuccessState extends NewStates {}

class NewGetBusinessErrorState extends NewStates {
  NewGetBusinessErrorState(this.error);

  final String error;
}

class NewGetSportsloadingState extends NewStates {}

class NewsGetSportsSuccessState extends NewStates {}

class NewGetSportsErrorState extends NewStates {
  NewGetSportsErrorState(this.error);

  final String error;
}

class NewGetScienceloadingState extends NewStates {}

class NewsGetScienceSuccessState extends NewStates {}

class NewGetScienceErrorState extends NewStates {
  NewGetScienceErrorState(this.error);

  final String error;
}


class NewGetSearchloadingState extends NewStates {}

class NewsGetSeacrchSuccessState extends NewStates {}

class NewGetSearchErrorState extends NewStates {
  NewGetSearchErrorState(this.error);

  final String error;
}
