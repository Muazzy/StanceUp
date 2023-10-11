import 'package:flutter/material.dart';
import 'package:fyp/models/video.dart';
import 'package:fyp/provider/video_provider.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoScreen extends StatelessWidget {
  final String title;
  final String query;

  const VideoScreen({super.key, required this.title, required this.query});
  @override
  Widget build(BuildContext context) {
    final videos = context.watch<VideoProvider>().videos;
    final bool isLoading = context.watch<VideoProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text("$title Suggested Videos"),
      ),
      body: GetBody(videos: videos, isLoading: isLoading),
    );
  }
}

class GetBody extends StatelessWidget {
  const GetBody({
    super.key,
    required this.videos,
    required this.isLoading,
  });

  final bool isLoading;
  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoTile(
          video: video,
          onTap: () {
            openVideo(video.url ?? '');
          },
        );
      },
      itemCount: videos.length,
    );
  }
}

class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
    required this.video,
    required this.onTap,
  });

  final VideoModel video;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 3,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          dense: false,
          isThreeLine: false,
          minVerticalPadding: 16,
          title: Text(
            video.title ?? '',
            style: const TextStyle(
              color: AppColors.primaryColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(video.author ?? ''),
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                video.thumbnail ?? defaultThumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(video.duration ?? ''),
              const SizedBox(width: 4),
              const Icon(
                Icons.watch_later,
                size: 20,
                color: AppColors.secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void openVideo(String url) async {
  try {
    await launchUrl(Uri.parse(url));
    print("success $url");
  } catch (e) {
    print(e);
  }
}
