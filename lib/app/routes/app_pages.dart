import 'package:get/get.dart';
import 'package:little_red_book/app/app.dart';
import 'package:little_red_book/app/modules/detail/detail_binding.dart';
import 'package:little_red_book/app/modules/detail/detail_page.dart';

import 'package:little_red_book/app/modules/home/home_binding.dart';
import 'package:little_red_book/app/modules/home/home_page.dart';
import 'package:little_red_book/app/modules/login/login_bindings.dart';
import 'package:little_red_book/app/modules/login/login_page.dart';
import 'package:little_red_book/app/modules/mall/mall_bindings.dart';
import 'package:little_red_book/app/modules/mall/mall_page.dart';
import 'package:little_red_book/app/modules/news/news_bindings.dart';
import 'package:little_red_book/app/modules/news/news_page.dart';
import 'package:little_red_book/app/modules/profile/profile_bindings.dart';
import 'package:little_red_book/app/modules/profile/profile_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => App(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.MALL,
      page: () => MallPage(),
      binding: MallBindings(),
    ),
    GetPage(
      name: Routes.NEWS,
      page: () => NewsPage(),
      binding: NewsBindings(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
  ];
}
