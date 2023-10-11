import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fyp/services/render_data_pushup.dart';
import 'package:fyp/widgets/custom_appbar.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';

import 'package:fyp/services/camera.dart';

class PushedPagePushup extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const PushedPagePushup(
      {super.key, required this.cameras, required this.title});
  @override
  _PushedPagePushupState createState() => _PushedPagePushupState();
}

class _PushedPagePushupState extends State<PushedPagePushup> {
  List<dynamic> _data = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  int x = 1;

  @override
  void initState() {
    super.initState();
    var res = loadModel();
    print('Model Response: ' + res.toString());
  }

  _setRecognitions(data, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _data = data;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  loadModel() async {
    return await Tflite.loadModel(
        model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Pushup Detection',
        query: 'How to do pushups',
        videoScreenTitle: 'Pushup',
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Camera(
              cameras: widget.cameras,
              setRecognitions: _setRecognitions,
            ),
            RenderDataPushUp(
              data: _data,
              previewH: max(_imageHeight, _imageWidth),
              previewW: min(_imageHeight, _imageWidth),
              screenH: screen.height,
              screenW: screen.width,
            ),
          ],
        ),
      ),
    );
  }
}
