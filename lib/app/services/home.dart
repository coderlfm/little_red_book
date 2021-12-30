import 'package:little_red_book/app/model/baseQuery.dart';
import 'package:little_red_book/app/model/note.dart';
import 'package:little_red_book/app/model/tab.dart';
import 'package:little_red_book/app/services/request.dart';

class HomeRequest {
  // 获取 tab 列表
  static Future<List<TabItem>> getTabList() async {
    final res = await Request.request('homefeed/categories?isMale=true',
        headers: {'X-Sign': 'Xdcfc84fd6bb94f4c63756224505811b8'});

    return List<TabItem>.from(res['data'].map((item) => TabItem.fromMap(item)));
  }

  // 获取 首页笔记
  static Future<List<NoteItem>> getReCommend(String tabUrl) async {
    final res = await Request.request(
        'homefeed/personalNotes?category=$tabUrl&cursorScore=&geo=&page=1&pageSize=20&needGifCover=true',
        headers: {'X-Sign': 'X5d78198d5d0cef0645770b2f36149fd3'});
    // print('res: $res');
    return List<NoteItem>.from(res['data'].map((item) => NoteItem.fromMap(item)));
  }
}
