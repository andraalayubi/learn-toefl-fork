import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/database/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final int id;
  final int idCategory;
  final List<Video> video;

  const VideoPage(
      {super.key,
      required this.id,
      required this.video,
      required this.idCategory});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Future<Video> _videoData;
  int? id;
  late String title;
  late String urlImage;
  late List<Video> allVideos;

  @override
  void initState() {
    super.initState();
    _videoData = getDataVideo(widget.id);
    allVideos = widget.video;
    id = widget.id;
    title = getTitle();
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
    final otherVideos =
        allVideos?.where((v) => v.id != id).take(3).toList() ?? [];

    return FutureBuilder<Video>(
        future: _videoData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      snapshot.data!.name,
                      style: const TextStyle(
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
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ClipPath(
                      // clipper: MyClipper(),
                      child: Container(
                        height: 310,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0D0443),
                        ),
                        child: YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data?.url ?? '',
                                flags: const YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              aspectRatio:
                                  16 / 9, // Rasio aspek 16:9 (lebar/tinggi)
                            ),
                            builder: (context, player) {
                              return Column(
                                children: [
                                  // some widgets
                                  player,
                                  //some other widgets
                                ],
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -80),
                      child: Container(
                        width: 360,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D0443),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Explore more ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'lesson videos now!',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Image.asset(
                                urlImage,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -65),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'More Videos',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -55),
                      child: Column(
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
                                            idCategory: widget.idCategory)));
                              },
                              child: Container(
                                height: 60,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 26, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  border: Border.all(
                                      width: 1.0, color: Colors.black),
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.play_circle_outline),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          v.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
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
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 180);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height - 180);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
