import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_logic.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DetailLogic>();

    final id = Get.parameters['id'];
    print('id: $id');

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text('详情'),
        ),
      ),
    );
  }
}
