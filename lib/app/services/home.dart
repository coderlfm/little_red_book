import 'package:little_red_book/app/model/baseQuery.dart';
import 'package:little_red_book/app/model/note.dart';
import 'package:little_red_book/app/services/request.dart';

class HomeRequest {
  static Future<List<NoteItem>> getReCommend() async {
    final res = await Request.request(
        'homefeed/personalNotes?category=recommend_v2&cursorScore=&geo=&page=1&pageSize=20&needGifCover=true',
        headers: {'X-Sign': 'X5d78198d5d0cef0645770b2f36149fd3'});
    print('res: $res');
    return List<NoteItem>.from(res['data'].map((item) => NoteItem.fromMap(item)));
  }
}
