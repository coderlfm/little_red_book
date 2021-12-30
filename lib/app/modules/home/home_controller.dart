import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_red_book/app/model/note.dart';
import 'package:little_red_book/app/services/home.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  List<NoteItem> personalNotes = []; // 笔记数组

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {}

  /// 下拉刷新
  void handleRefresh(BuildContext context) async {
    print('下拉');
    personalNotes = await HomeRequest.getReCommend();
    update();
    refreshController.refreshCompleted();
  }

  /// 上拉加载更多
  void handleLoading(BuildContext context) async {
    print('加载中');

    await getData();
    refreshController.loadComplete();
    // return Future.delayed(Duration(seconds: 2), () => refreshController.loadComplete());

    /// TODO: 此处需要设置成已加载完毕
    // if (res > 0) {
    //   _refreshController.loadComplete();
    // } else {
    //   _refreshController.loadNoData();
    // }
  }

  /// 请求数据
  Future<void> getData() async {
    final res = await HomeRequest.getReCommend();
    personalNotes = [...personalNotes, ...res];
    update();
  }
}
