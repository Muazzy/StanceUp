import 'package:flutter/material.dart';
import 'package:fyp/models/video.dart';
import 'package:fyp/services/youtube_service.dart';

class VideoProvider with ChangeNotifier {
  bool isLoading = false;
  List<VideoModel> videos = [];

  void search(String query) async {
    isLoading = true;
    videos = [];
    notifyListeners();
    try {
      videos = await YoutubeService.searchVideos(query);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e);
    }
  }
}
