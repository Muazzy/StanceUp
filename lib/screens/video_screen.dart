import 'package:flutter/material.dart';
import 'package:fyp/models/video.dart';
import 'package:fyp/provider/video_provider.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.query, required this.title});

  final String title;
  final String query;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    // context.read<VideoProvider>().search(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final videos = context.watch<VideoProvider>().videos;
    final bool isLoading = context.watch<VideoProvider>().isLoading;

    print(videos);
    print(isLoading);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(videos[index].title ?? ''),
          subtitle: Text(videos[index].author ?? ''),
        );
      },
      itemCount: videos.length,
    );
  }
}
