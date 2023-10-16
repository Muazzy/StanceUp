import 'package:fyp/constants/yoga_poses.dart';
import 'package:fyp/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fyp/pushed_page_pushup.dart';
import 'package:fyp/screens/yoga_screens/inference_page.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/widgets/search_bar.dart';

import 'pushed_pageA.dart';
import 'pushed_pageS.dart';
import 'pushed_pageY.dart';

class MainScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MainScreen(this.cameras, {super.key});

  static const String id = 'main_screen';
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: RichText(
            text: TextSpan(
              text: 'StanceUp',
              children: [
                TextSpan(
                  text: ' - your smart trainer',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                )
              ],
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
              ),
            ),
          ),
        ),
        Expanded(
          // flex: 3,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'Strength Alignment',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: [
                      AlignmentCard(
                        title: 'Arm press',
                        assetImagePath: 'assets/images/arm-press.png',
                        onTap: () =>
                            onSelectA(context: context, modelName: 'posenet'),
                      ),
                      AlignmentCard(
                        title: 'Squat',
                        assetImagePath: 'assets/images/squat.png',
                        onTap: () =>
                            onSelectS(context: context, modelName: 'posenet'),
                      ),
                      AlignmentCard(
                        title: 'Pushup',
                        assetImagePath: 'assets/images/pushup.png',
                        onTap: () => onSelectPushup(
                            context: context, modelName: 'posenet'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'Yoga Alignment',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    scrollDirection: Axis.horizontal,
                    // children: [
                    //   HorizontalAlignmentCard(
                    //     title: 'Warrior Pose',
                    //     assetImagePath: 'assets/images/warrior_pose.png',
                    //     onTap: () =>
                    //         onSelectY(context: context, modelName: 'posenet'),
                    //   ),
                    //   HorizontalAlignmentCard(
                    //     title: beginnerYogaPoses[0],
                    //     assetImagePath:
                    //         "assets/images/poses/${beginnerYogaPoses[0]}.png",
                    //     onTap: () =>
                    //         onSelectYoga(context, beginnerYogaPoses[0]),
                    //   ),
                    // ],
                    children: List.generate(
                          beginnerYogaPoses.length,
                          (index) => HorizontalAlignmentCard(
                            title: beginnerYogaPoses[index],
                            assetImagePath:
                                "assets/images/poses/${beginnerYogaPoses[index]}.png",
                            onTap: () =>
                                onSelectYoga(context, beginnerYogaPoses[index]),
                          ),
                        ) +
                        List.generate(
                          intermediateYogaPoses.length,
                          (index) => HorizontalAlignmentCard(
                            title: intermediateYogaPoses[index],
                            assetImagePath:
                                "assets/images/poses/${intermediateYogaPoses[index]}.png",
                            onTap: () => onSelectYoga(
                              context,
                              intermediateYogaPoses[index],
                            ),
                          ),
                        ) +
                        List.generate(
                          advanceYogaPoses.length,
                          (index) => HorizontalAlignmentCard(
                            title: advanceYogaPoses[index],
                            assetImagePath:
                                "assets/images/poses/${advanceYogaPoses[index]}.png",
                            onTap: () => onSelectYoga(
                              context,
                              advanceYogaPoses[index],
                            ),
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    // );
  }
}

class AlignmentCard extends StatelessWidget {
  const AlignmentCard({
    super.key,
    required this.title,
    required this.assetImagePath,
    required this.onTap,
  });

  final String title;
  final String assetImagePath;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 2,
        shadowColor: AppColors.primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(assetImagePath),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalAlignmentCard extends StatelessWidget {
  const HorizontalAlignmentCard({
    super.key,
    required this.title,
    required this.assetImagePath,
    required this.onTap,
  });

  final String title;
  final String assetImagePath;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 2,
        shadowColor: AppColors.primaryColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(assetImagePath),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void onSelectA(
    {required BuildContext context, required String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageA(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}

void onSelectS(
    {required BuildContext context, required String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageS(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}

void onSelectY(
    {required BuildContext context, required String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageY(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}

void onSelectPushup(
    {required BuildContext context, required String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPagePushup(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}

// for yoga
void onSelectYoga(BuildContext context, String customModelName) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => InferencePage(
        cameras: cameras,
        title: customModelName,
        // model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
        model: "assets/posenet_mv1_075_float_from_checkpoints.tflite",
        customModel: customModelName,
      ),
    ),
  );
}
