import 'package:flutter/material.dart';
import 'package:little_red_book/app/modules/home/home_page.dart';
import 'package:little_red_book/app/modules/mall/mall_page.dart';
import 'package:little_red_book/app/modules/news/news_page.dart';
import 'package:little_red_book/app/modules/profile/profile_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var items2 = [
      BottomNavigationBarItem(icon: Text('首页'), label: ''),
      BottomNavigationBarItem(icon: Text('商城'), label: ''),
      BottomNavigationBarItem(icon: Text('消息'), label: ''),
      BottomNavigationBarItem(icon: Text('我'), label: ''),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [HomePage(), MallPage(), NewsPage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: items2,
      ),
    );
  }
}
