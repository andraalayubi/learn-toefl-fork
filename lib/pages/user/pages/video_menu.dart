import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/models/video.dart';
import 'package:learn_toefl/pages/user/pages/video.dart';
import 'package:learn_toefl/services/video_history.dart';
import 'package:learn_toefl/services/video_fav.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/widget/bottom_navigation.dart';

class VideoListPage extends StatefulWidget {
  final String title;
  final int id;

  const VideoListPage({super.key, required this.title, required this.id});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  late Future<List<VideoCategory>> _futureCategories;
  late String description;
  late String urlCardImage;
  List<Video> allVideos = [];
  late List<bool> _isExpandedList; // List untuk menyimpan status ekspansi

  // ignore: unused_field
  late Future<List<dynamic>> _history;
  void _showFavorites() async {
    List<dynamic> favorites = await VideoFav.getFavs();
    print(favorites);
    favorites.forEach((video) {
      print(
          'ID: ${video['id']}, Name: ${video['name']}, Category: ${video['category']}, URL: ${video['url']}');
    });
  }

  @override
  void initState() {
    super.initState();
    _futureCategories =
        fetchVideos(widget.id); // Ganti 1 dengan vid yang diinginkan
    description = getDescription();
    _isExpandedList = List<bool>.generate(
        10, (index) => false); // Ganti 10 dengan jumlah kategori
  }

  void insertHistory(int id, String name, String url) async {
    print('otw nambah $id');
    await VideoHistory.addHistory(id, name, widget.id, widget.title, url);
  }

  String getDescription() {
    if (widget.id == 1) {
      description =
          'Get ready to elevate your English proficiency with our comprehensive TOEFL lessons.';
      urlCardImage = 'assets/images/writing.png';
    } else if (widget.id == 2) {
      description =
          'Grammar serves as the backbone of language, ensuring clarity and precision in communication.';
      urlCardImage = 'assets/images/reading-book.png';
    } else {
      description = 'Default description';
      urlCardImage = 'assets/images/reading-book.png';
    }
    return description;
  }

  Future<List<dynamic>> fetchHistory() async {
    var videoHistory = await VideoHistory.getHistory();
    print('videoHistory $videoHistory');
    return videoHistory;
  }

  void showCustomSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                style: tFOnt(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: tFOnt(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D0443),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()));
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Transform.translate(
                offset: const Offset(0, -90),
                child: Container(
                  height: 190,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D0443),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Expanded(
                      // child: Container(
                      //   height: 50,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         width: 300,
                      //         height: 40,
                      //         decoration: const BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(12),
                      //             bottomLeft: Radius.circular(12),
                      //           ),
                      //         ),
                      //         child: TextField(
                      //           // onChanged: ,
                      //           decoration: InputDecoration(
                      //             hintText: "Search here",
                      //             hintStyle: tFOnt(),
                      //             border: InputBorder.none,
                      //             contentPadding: const EdgeInsets.only(
                      //                 left: 12, bottom: 12),
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 40,
                      //         height: 40,
                      //         decoration: const BoxDecoration(
                      //           color: Color.fromARGB(255, 252, 232, 177),
                      //           borderRadius: BorderRadius.only(
                      //             topRight: Radius.circular(12),
                      //             bottomRight: Radius.circular(12),
                      //           ),
                      //         ),
                      //         child: const Icon(
                      //           Icons.search,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -110),
              child: Container(
                width: 360,
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 2),
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            style: tFOnt(
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
                        urlCardImage,
                        width: 105,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child: FutureBuilder<List<VideoCategory>>(
                future: _futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (var category in snapshot.data!) {
                      for (var video in category.videos) {
                        allVideos.add(Video(
                            id: video.id, name: video.name, url: video.url));
                      }
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Row(
                              children: [
                                Image.asset(
                                    'assets/images/iconVideo_${snapshot.data![index].id}.png',
                                    width: 35,
                                    height: 35),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].name,
                                      style: tFOnt(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${snapshot.data![index].videos.length} Material",
                                      style: tFOnt(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: snapshot.data![index].videos.map((video) {
                              return GestureDetector(
                                onTap: () {
                                  insertHistory(
                                      video.id, video.name, video.url);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoPage(
                                              id: video.id,
                                              idCategory: widget.id,
                                              video: allVideos)));
                                },
                                child: ListTile(
                                  title: Text(
                                    video.name,
                                    style: tFOnt(fontSize: 12),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      try {
                                        bool isFavorite =
                                            await VideoFav.isFavorite(video.id);

                                        if (isFavorite) {
                                          showCustomSnackbar(
                                              context,
                                              'Already exist in favorites',
                                              Colors.orange);
                                        } else {
                                          await VideoFav.addFav(
                                            video.id,
                                            video.name,
                                            widget.id,
                                            "Category Name",
                                            video.url,
                                          );

                                          showCustomSnackbar(
                                              context,
                                              '${video.name} Added to favorites!',
                                              Colors.green);
                                        }
                                      } catch (e) {
                                        showCustomSnackbar(
                                            context,
                                            'Failed to add to favorites',
                                            Colors.red);
                                      }
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 24, 11, 70),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.heart_circle_fill,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          // SizedBox(height: 10);
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: _showFavorites,
            //   child: Text('Show Favorites'),
            // ), // SizedBox(height: 200),
          ],
        ),
      ),
    );
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
