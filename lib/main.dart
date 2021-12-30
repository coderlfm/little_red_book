import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:little_red_book/app/modules/home/home_binding.dart';
import 'package:little_red_book/core/theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "小红书",
      initialRoute: AppPages.INITIAL,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
      theme: AppTheme.theme,
    ),
  );
}
