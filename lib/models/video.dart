import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoModel {
  String? title;
  String? author;
  String? duration;
  String? thumbnail;
  String? id;
  String? url;

  VideoModel({
    this.title = '',
    this.author = '',
    this.duration = '',
    this.thumbnail = defaultThumbnail,
    this.id = '',
    this.url = '',
  });

  VideoModel.fromVideo(Video video) {
    author = video.author;
    title = video.title;
    duration = getDurationString(video.duration ?? const Duration(seconds: 0));
    thumbnail = video.thumbnails.mediumResUrl;
    id = video.id.value;
    url = video.url;
  }
}

const String defaultThumbnail =
    'https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png';

getDurationString(Duration duration) {
  int totalTimeinseconds = duration.inSeconds;

  int totalHours = totalTimeinseconds ~/ 3600;

  int totalRemainingTimeMinusTheHours = totalTimeinseconds % 3600;

  int totalMinutes = totalRemainingTimeMinusTheHours ~/ 60;
  int totalSeconds = totalRemainingTimeMinusTheHours % 60;

  if (totalHours == 0) {
    return '$totalMinutes:$totalSeconds';
  } else {
    return '$totalHours:$totalMinutes:$totalSeconds';
  }
}
