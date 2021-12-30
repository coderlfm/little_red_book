import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:little_red_book/app/model/note.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
// TabController tabController = TabController(length: 2, vsync: this);;

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>();

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: CupertinoPageScaffold(
        navigationBar: buildAppBar(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: DefaultTabController(
                  length: 4,
                  child: TabBar(
                    tabs: [
                      Tab(icon: Text('家具家装', style: TextStyle(color: Colors.black54))),
                      Tab(icon: Text('职场', style: TextStyle(color: Colors.black54))),
                      Tab(icon: Text('科技数码', style: TextStyle(color: Colors.black54))),
                      Tab(icon: Text('影视', style: TextStyle(color: Colors.black54))),
                      // Tab(icon: Text('学习', style: TextStyle(color: Colors.black54))),
                    ],
                  ),
                ),
              ),
              Expanded(
                // child: CustomScrollView(slivers: ,),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  footer: CustomFooter(builder: buildFooter),
                  controller: controller.refreshController,
                  onRefresh: () => controller.handleRefresh(context),
                  onLoading: () => controller.handleLoading(context),
                  child: CustomScrollView(slivers: [buildNotes()]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4, //横轴单元格数量
                itemCount: controller.personalNotes.length, //元素数量
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(4),
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  final note = controller.personalNotes[index];
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
  Container buildNote(NoteItem note) {
    return Container(
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

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
