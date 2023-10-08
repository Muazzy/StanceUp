import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp/provider/video_provider.dart';
import 'package:fyp/screens/video_screen.dart';
import 'package:provider/provider.dart';

AppBar customAppBar(
  BuildContext context, {
  required String title,
  required String query,
  required String videoScreenTitle,
}) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
    centerTitle: false,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black, fontSize: 16),
    ),
    backgroundColor: Colors.white.withOpacity(1),
    actions: [
      IconButton(
        onPressed: () {
          // Future.delayed()
          context.read<VideoProvider>().search(query);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VideoScreen(query: query, title: videoScreenTitle),
            ),
          );
        },
        icon: SvgPicture.asset('assets/images/logo.svg'),
      ),
    ],
    leading: IconButton(
      constraints: const BoxConstraints(),
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    elevation: 0,
  );
}
