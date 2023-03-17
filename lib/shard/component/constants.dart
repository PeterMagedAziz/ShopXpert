import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salla_app/layout/cubit/cubit.dart';
import 'package:salla_app/shard/component/component.dart';
import 'package:salla_app/shard/network/local/cache_helper.dart';
import 'package:salla_app/shard/size_config.dart';
import 'package:get_it/get_it.dart';

import '../../modules/login/shop_login_screen.dart';
GetIt di = GetIt.I..allowReassignment = true;
dynamic token = '';
const TextStyle textStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w500);
const kPrimaryColor = Colors.deepOrange;
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);


// String? token;
void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
        (value) {
      navigateReplacementTo(
        context,
        const ShopLoginScreen(),
      );
    },
  );
}


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


