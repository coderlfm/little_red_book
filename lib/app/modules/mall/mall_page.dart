import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './mall_controller.dart';

class MallPage extends GetView<MallController> {
    
    const MallPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('MallPage'),),
            body: Container(),
        );
    }
}