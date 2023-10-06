import 'package:flutter/material.dart';

class RenderDataPushUp extends StatefulWidget {
  final List<dynamic> data;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  RenderDataPushUp(
      {required this.data,
      required this.previewH,
      required this.previewW,
      required this.screenH,
      required this.screenW});

  @override
  _RenderDataPushUpState createState() => _RenderDataPushUpState();
}

class _RenderDataPushUpState extends State<RenderDataPushUp> {
  late Map<String, List<double>> inputArr;
  late bool midCount, isCorrectPosture;
  late int _counter;
  late Color correctColor;
  String whatToDo = 'Finding Posture';

  // Define your state variables and constants here.
  var leftEyePos = Vector(0, 0);
  var rightEyePos = Vector(0, 0);
  var leftShoulderPos = Vector(0, 0);
  var rightShoulderPos = Vector(0, 0);
  var leftElbowPos = Vector(0, 0);
  var rightElbowPos = Vector(0, 0);
  var leftWristPos = Vector(0, 0);
  var rightWristPos = Vector(0, 0);
  var leftHipPos = Vector(0, 0);
  var rightHipPos = Vector(0, 0);
  var leftKneePos = Vector(0, 0);
  var rightKneePos = Vector(0, 0);
  var leftAnklePos = Vector(0, 0);
  var rightAnklePos = Vector(0, 0);

  @override
  void initState() {
    inputArr = {};
    midCount = false;
    isCorrectPosture = false;
    _counter = 0;
    correctColor = Colors.red;
    super.initState();
  }

  // Define your push-up posture conditions here.
  bool _postureAccordingToExercise(Map<String, List<double>> poses) {
    // Implement the push-up posture conditions based on keypoints.
    // Return true if the posture is correct for a push-up.
    // Return false otherwise.
    if (poses['leftShoulder'] != null &&
        poses['rightShoulder'] != null &&
        poses['leftElbow'] != null &&
        poses['rightElbow'] != null) {
      double leftShoulderY = poses['leftShoulder']![1];
      double rightShoulderY = poses['rightShoulder']![1];
      double leftElbowY = poses['leftElbow']![1];
      double rightElbowY = poses['rightElbow']![1];

      // Define your push-up posture conditions here.
      // You may need to adjust these thresholds based on your requirements.
      return (leftShoulderY > rightHipPos.y &&
          rightShoulderY > leftHipPos.y &&
          leftElbowY < leftShoulderY &&
          rightElbowY < rightShoulderY);
    }
    return false;
  }

  // Implement the logic to check for correct posture and count push-ups.
  void _checkCorrectPostureAndCount(Map<String, List<double>> poses) {
    // Implement the logic here to check for the correct push-up posture
    // and count the push-ups.
    if (_postureAccordingToExercise(poses)) {
      if (!isCorrectPosture) {
        setState(() {
          isCorrectPosture = true;
          correctColor = Colors.green;
        });
      }
    } else {
      if (isCorrectPosture) {
        setState(() {
          isCorrectPosture = false;
          correctColor = Colors.red;
        });
      }
    }

    // Logic to count push-ups.
    if (isCorrectPosture && midCount == false) {
      // Correct initial posture for push-up
      setState(() {
        whatToDo = 'Push Down';
        //correctColor = Colors.green;
      });
      isCorrectPosture = false;
    }

    // Push-up phase completed.
    if (isCorrectPosture && midCount == true) {
      midCount = false;
      _incrementCounter();
      isCorrectPosture = false;
      setState(() {
        whatToDo = 'Push Up';
        //correctColor = Colors.green;
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Implement the rendering of keypoints and lines for push-up detection.
    // Use CustomPainter or other widgets for this purpose.

    return Stack(
      children: <Widget>[
        // Implement your rendering logic for keypoints and lines here.

        // Add a UI element to display the push-up count and exercise phase.
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: widget.screenW,
            decoration: BoxDecoration(
              color: correctColor, // Change the color as needed.
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                // Display push-up count and exercise phase here.
                Text(
                  'Push-Ups: $_counter', // Update the count dynamically.
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Phase: $whatToDo', // Update the phase dynamically.
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Vector {
  double x, y;
  Vector(this.x, this.y);
}

class MyPainter extends CustomPainter {
  Vector left;
  Vector right;
  MyPainter({required this.left, required this.right});
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(left.x, left.y);
    final p2 = Offset(right.x, right.y);
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
