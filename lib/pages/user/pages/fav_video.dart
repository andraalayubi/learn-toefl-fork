import 'package:flutter/material.dart';
import 'package:learn_toefl/models/video.dart';
import 'package:learn_toefl/pages/user/pages/video.dart';
import 'package:learn_toefl/utilities.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VideoFav {
  static const String _favKey = 'video_fav';

  static Future<void> addFav(
      int id, String name, int id_category, String category, String url) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> videoFavorite = prefs.getStringList(_favKey) ?? [];
    Map<String, dynamic> videoMap = {
      'id': id,
      'name': name,
      'id_category': id_category,
      'category': category,
      'url': url,
    };
    videoFavorite.removeWhere((videoJson) {
      final Map<String, dynamic> existingVideoMap = jsonDecode(videoJson);
      return existingVideoMap['id'] == id;
    });
    videoFavorite.insert(0, jsonEncode(videoMap));
    // while (videoFavorite.length > 5) {
    //   videoFavorite.removeLast();
    // }
    await prefs.setStringList(_favKey, videoFavorite);
  }

  static Future<void> removeFav(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> videoFavorite = prefs.getStringList(_favKey) ?? [];
    videoFavorite.removeWhere((videoJson) {
      final Map<String, dynamic> existingVideoMap = jsonDecode(videoJson);
      return existingVideoMap['id'] == id;
    });
    await prefs.setStringList(_favKey, videoFavorite);
  }

  static Future<List<dynamic>> getFavs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> videoHistory = prefs.getStringList(_favKey) ?? [];
    return videoHistory.map((videoJson) => jsonDecode(videoJson)).toList();
  }
}

class FavVideo extends StatefulWidget {
  const FavVideo({super.key});

  @override
  State<FavVideo> createState() => _FavVideoState();
}

class _FavVideoState extends State<FavVideo> {
  List<dynamic> _favoriteVideos = [];
  List<Video> _allVideos = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteVideos();
  }

  void _loadFavoriteVideos() async {
    List<dynamic> favorites = await VideoFav.getFavs();
    setState(() {
      _favoriteVideos = favorites;
    });
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
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0443),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "FAVORITE VIDEO",
          style: tFOnt(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          constraints: BoxConstraints(minHeight: screenHeight),
          width: containerWidth,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [mColor, mColor.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.4, 1],
                    ),
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
                              'Let’s see your Favorite Video HoHoHo',
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
                          'assets/images/reading-book.png',
                          width: 85,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_favoriteVideos.isEmpty)
                Center(
                  child: Text(
                    'No Favorite Videos',
                    style: tFOnt(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _favoriteVideos.length,
                  itemBuilder: (context, index) {
                    final video = _favoriteVideos[index];

                    _allVideos.add(Video(
                        id: video['id'],
                        name: video['name'],
                        url: video['url']));

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPage(
                              id: video['id'],
                              idCategory: video['id_category'],
                              video: _allVideos,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(width: 1.0, color: Colors.black),
                        ),
                        child: ListTile(
                            title: Text(
                              video['name'],
                              style: tFOnt(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () {
                                  _showConfirmationDialog(
                                      context, index, video);
                                })),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, int index, Map<String, dynamic> video) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Are you sure you want to delete this video from your favorites?',
            style: tFOnt(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: TextButton(
                child: Text(
                  'Batal',
                  style: tFOnt(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 171, 52, 44),
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: TextButton(
                child: Text(
                  'Delete',
                  style: tFOnt(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _favoriteVideos.removeAt(index);
                  });
                  VideoFav.removeFav(video['id']);
                  showCustomSnackbar(
                    context,
                    '${video['name']} Deleted From Favorites!',
                    Colors.green,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
