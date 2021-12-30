import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './news_controller.dart';

class NewsPage extends GetView<NewsController> {
    
    const NewsPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('NewsPage'),),
            body: Container(),
        );
    }
}