import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:little_red_book/app/routes/app_pages.dart';
import './login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [VideoBg(), buildSlogan(context, height), buildActions(height, context, width)],
      ),
    );
  }

  Positioned buildActions(double height, BuildContext context, double width) {
    return Positioned(
      bottom: height * .05,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '+86 177****6189',
              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(Routes.HOME);
              },
              child: Text('一键登录'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
                minimumSize: MaterialStateProperty.all(Size(width * .8, 42)),
                maximumSize: MaterialStateProperty.all(Size(width * .8, 42)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(Routes.HOME);
              },
              child: Text('微信登录'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white38),
                minimumSize: MaterialStateProperty.all(Size(width * .8, 42)),
                maximumSize: MaterialStateProperty.all(Size(width * .8, 42)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
              ),
            ),
            SizedBox(height: 20),
            Text('其它登录方式 >', style: TextStyle(color: Colors.white)),
            SizedBox(height: 60),
            Text('我已阅读并同意', style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  Positioned buildSlogan(BuildContext context, double height) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * .15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '一起引领潮流',
            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class VideoBg extends StatefulWidget {
  const VideoBg({Key? key}) : super(key: key);

  @override
  _VideoBgState createState() => _VideoBgState();
}

class _VideoBgState extends State<VideoBg> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    player.setDataSource('asset:///assets/video/login_bg.mp4', autoPlay: true);
    player.addListener(() {
      if (player.state == FijkState.completed) player.start();
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return FijkView(player: player, fit: FijkFit.cover);
  }
}
