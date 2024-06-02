import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/models/video.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final int id;
  final int idCategory;
  final List<Video> video;

  const VideoPage({
    Key? key,
    required this.id,
    required this.video,
    required this.idCategory,
  }) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Future<Video> _videoData;
  int? id;
  late String title;
  late String urlImage;
  late List<Video> allVideos;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _videoData = getDataVideo(widget.id);
    allVideos = widget.video;
    id = widget.id;
    title = getTitle();
    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  String getTitle() {
    if (widget.idCategory == 1) {
      title = 'LESSON';
      urlImage = 'assets/images/waiting.png';
    } else if (widget.idCategory == 2) {
      title = 'GRAMMAR';
      urlImage = 'assets/images/proud.png';
    } else {
      title = '';
      urlImage = 'assets/images/waiting.png';
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    final otherVideos = allVideos.where((v) => v.id != id).take(3).toList();

    return FutureBuilder<Video>(
      future: _videoData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Column(
                children: [
                  Text(
                    title,
                    style: tFOnt(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    snapshot.data!.name,
                    style: tFOnt(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              backgroundColor: const Color(0xFF0D0443),
              leading: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    aspectRatio: 16 / 9,
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      _controller.load(snapshot.data?.url ?? '');
                      _controller.addListener(() {
                        if (_controller.value.isFullScreen) {
                          SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.manual,
                            overlays: [],
                          );
                        } else {
                          SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.manual,
                            overlays: SystemUiOverlay.values,
                          );
                        }
                      });
                    },
                  ),
                  builder: (context, player) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: constraints.maxWidth * (9 / 16),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D0443),
                              ),
                              child: player ?? SizedBox(), // Handle null player
                            ),
                            SizedBox(height: 35),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      mColor,
                                      mColor.withOpacity(0.8),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.4, 1],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explore more $title videos now!',
                                      style: tFOnt(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Image.asset(
                                      urlImage,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'More Videos',
                                style: tFOnt(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                ...otherVideos.map(
                                  (v) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VideoPage(
                                            id: v.id,
                                            video: allVideos,
                                            idCategory: widget.idCategory,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 60,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        border: Border.all(
                                          width: 1.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child:
                                                Icon(Icons.play_circle_outline),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                v.name,
                                                style: tFOnt(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
