import 'package:flutter_application_1/moduels/shop_app/login/login_shop.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';

void Singout(context) {
  CacheHelper.sharedPreferences.remove('token').then((value) {
    if (value) {
      NavigateAndFinish(context, LoginShop_Screen());
    }
  });
}

void printFullText(String text) {
  final Pattern = RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
