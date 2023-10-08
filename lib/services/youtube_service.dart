import 'package:fyp/models/video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  static Future<List<VideoModel>> searchVideos(String query) async {
    try {
      YoutubeExplode yt = YoutubeExplode();

      final searchResult = await yt.search(query, filter: TypeFilters.video);

      List<VideoModel> videos = searchResult
          .map((Video video) => VideoModel.fromVideo(video))
          .toList();

      return videos;
    } catch (e) {
      return [];
    }
  }
}
