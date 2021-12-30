import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:little_red_book/app/model/note.dart';
import 'package:little_red_book/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
// TabController tabController = TabController(length: 2, vsync: this);;

  @override
  Widget build(BuildContext context) {
    Get.find<HomeLogic>();

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: CupertinoPageScaffold(
        navigationBar: buildAppBar(),
        child: SafeArea(
          child: Column(
            children: [
              buildTab(),
              Expanded(
                // child: CustomScrollView(slivers: ,),
                child: GetBuilder<HomeLogic>(
                  assignId: true,
                  builder: (logic) {
                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropHeader(),
                      footer: CustomFooter(builder: buildFooter),
                      controller: logic.refreshController,
                      onRefresh: () => logic.handleRefresh(context),
                      onLoading: () => logic.handleLoading(context),
                      child: CustomScrollView(slivers: [buildNotes()]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder buildTab() {
    return GetBuilder<HomeLogic>(
      assignId: true,
      builder: (logic) {
        return Container(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: logic.tabList.length,
            itemBuilder: (ctx, index) {
              final item = logic.tabList[index];
              final isActive = logic.currentTab == item.oid;

              return GestureDetector(
                onTap: () {
                  logic.handleChangeCurrentTab(item.oid);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Center(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: isActive ? Colors.black : Colors.black54,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    // return GetBuilder<HomeLogic>(
    //   assignId: true,
    //   builder: (logic) {
    //     return ListView(
    //       physics: ScrollPhysics(),
    //       // scrollDirection: Axis.horizontal,
    //       children: [
    //         Text('111', style: TextStyle(color: Colors.black54)),
    //         Text('222', style: TextStyle(color: Colors.black54)),
    //         Text('333', style: TextStyle(color: Colors.black54)),
    //       ],
    //     );
    //     return TabBar(
    //       tabs: List.generate(
    //         3,
    //         (index) => Tab(icon: Text(logic.tabList[index].name, style: TextStyle(color: Colors.black54))),
    //       ),
    //     );
    //   },
    // );
  }

  CupertinoNavigationBar buildAppBar() {
    return CupertinoNavigationBar(
      backgroundColor: Colors.white,
      middle: TabBar(
        indicatorColor: Colors.red,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(child: Text('关注', style: TextStyle(color: Colors.black))),
          Tab(child: Text('发现', style: TextStyle(color: Colors.black))),
          Tab(child: Text('成都', style: TextStyle(color: Colors.black))),
        ],
      ),
      leading: Icon(Icons.adjust, color: Colors.black54),
      trailing: IconButton(icon: const Icon(Icons.search, color: Colors.black54), onPressed: () {}),
    );
  }

  // 构建笔记
  SliverList buildNotes() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          color: Color(0xfff1f1f1),
          child: GetBuilder<HomeLogic>(
            builder: (logic) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                //横轴单元格数量
                itemCount: logic.personalNotes.length,
                //元素数量
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(4),
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  final note = logic.personalNotes[index];
                  return buildNote(note);
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              );
            },
          ),
        );
      }),
    );
  }

  // 构建笔记
  GestureDetector buildNote(NoteItem note) {
    return GestureDetector(
      onTap: () {
        print('点击');
        Get.toNamed('${Routes.DETAIL}?id=${note.id}');
      },
      child: Container(
        key: ValueKey(note.id),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 笔记主图
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              child: FadeInImage(
                  placeholder: AssetImage('assets/images/ads_common_logo_night.png'),
                  image: NetworkImage(note.cover.url)),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note.title),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 头像，昵称
                      Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(note.user.image, width: 20, height: 20),
                        ),
                        SizedBox(width: 5),
                        Container(width: 80, child: Text(note.user.nickname, overflow: TextOverflow.ellipsis))
                      ]),
                      // 收藏
                      Row(children: [
                        Icon(Icons.favorite_border, size: 20),
                        SizedBox(width: 5),
                        Text(note.likes.toString()),
                      ]),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFooter(BuildContext context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = Text("上拉加载");
    } else if (mode == LoadStatus.loading) {
      body = CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = Text("加载失败！点击重试！");
    } else if (mode == LoadStatus.canLoading) {
      body = Text("松手,加载更多!");
    } else {
      body = Text("没有更多数据了!");
    }
    return Container(
      height: 55.0,
      child: Center(child: body),
    );
  }
}
