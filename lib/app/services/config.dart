class Config {
  static const baseUrl = 'https://www.xiaohongshu.com/fe_api/burdock/weixin/v2/';
  static const timeout = 10000;
  static const method = 'get';

  static const Map<String, dynamic> headers = {
    'X-Sign': ' X5d78198d5d0cef0645770b2f36149fd3',
    'Authorization': ' wxmp.fe4b8835-cbb5-48c2-bcec-ead934dd2d5f',
    'User-Agent':
        ' Mozilla/5.0 (iPhone; CPU iPhone OS 14_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.16(0x1800103e) NetType/WIFI Language/zh_CN'
  };
}
