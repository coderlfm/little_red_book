import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_red_book/app/model/note.dart';
import 'package:little_red_book/app/model/tab.dart';
import 'package:little_red_book/app/services/home.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeLogic extends GetxController {
  List<NoteItem> personalNotes = []; // 笔记数组
  List<TabItem> tabList = []; // tab数组
  String currentTab = ''; // 当前tab url

  final RefreshController refreshController = RefreshController(initialRefresh: false); // 刷新控制器

  @override
  void onInit() async {
    super.onInit();

    await getTabData();
    await getData();
  }

  @override
  void onClose() {}

  /// 下拉刷新
  void handleRefresh(BuildContext context) async {
    print('下拉');
    personalNotes = await HomeRequest.getReCommend(currentTab);
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

  /// 修改当前选中 tab
  void handleChangeCurrentTab(String url) async {
    currentTab = url;
    update();

    /// 重新请求笔记数据
    personalNotes = await HomeRequest.getReCommend(currentTab);
  }

  /// 请求笔记数据
  Future<void> getData() async {
    final res = await HomeRequest.getReCommend(currentTab);
    personalNotes = [...personalNotes, ...res];
    update();
  }

  /// 请求tab数据
  Future<void> getTabData() async {
    final res = await HomeRequest.getTabList();
    tabList = res;
    handleChangeCurrentTab(res[0].oid);
    update();
  }
}
