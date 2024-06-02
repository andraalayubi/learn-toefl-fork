import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/pages/user/pages/fav_video.dart';
import 'package:learn_toefl/pages/user/pages/history_video.dart';
import 'package:learn_toefl/services/video_history.dart';
import 'package:learn_toefl/models/article_model.dart';
import 'package:learn_toefl/pages/user/pages/translate.dart';
import 'package:learn_toefl/models/video.dart';

import 'package:learn_toefl/pages/user/pages/video.dart';
import 'package:learn_toefl/pages/user/pages/video_menu.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/widget/article_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late Future<List<dynamic>> _history;
  List<Video> allVideos = [];

  @override
  void initState() {
    super.initState();
    _history = fetchHistory();
  }

  Future<List<dynamic>> fetchHistory() async {
    var videoHistory = await VideoHistory.getHistory();
    print('videoHistory $videoHistory');
    return videoHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ToeTion',
                style: tFOnt(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavVideo(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: mColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration.zero, () {
              _history = fetchHistory();
            });
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              mColor,
                              mColor.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.4, 1],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Welcome to ToeTion',
                                      style: tFOnt(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Ignite Your TOEFL Journey with Passion and Purpose!',
                                      style: tFOnt(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/images/welcome.png', // Ganti dengan path gambar Anda
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        children: [
                          // TOEFL Prep Section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOEFL Prep',
                                style: tFOnt(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const VideoListPage(
                                                    title: 'LESSON', id: 1)));
                                  },
                                  child: Container(
                                    height: 150,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white,
                                          Color.fromARGB(255, 255, 241, 236),
                                          Color.fromRGBO(255, 148, 113, 0.4)
                                        ],
                                        stops: [0, 0.14, 0.42, 1],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 0.8,
                                        color: Colors.black12,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 197, 196, 196),
                                          offset: Offset(2, 4),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/vocabolary.png', // Ganti dengan path gambar Anda
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Lesson',
                                            style: tFOnt(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const VideoListPage(
                                                title: 'GRAMMAR', id: 2),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color.fromRGBO(255, 253, 240, 0.65),
                                          Color.fromRGBO(255, 241, 114, 0.6)
                                        ],
                                        stops: [0, 0.5, 1],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 0.8,
                                        color: Colors.black12,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 197, 196, 196),
                                          offset: Offset(2, 4),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/grammar.png',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Grammar',
                                            style: tFOnt(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TranslatePage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color.fromARGB(255, 230, 244, 255),
                                          Color.fromRGBO(156, 200, 235, 0.8)
                                        ],
                                        stops: [0, 0.5, 1],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 0.8,
                                        color: Colors.black12,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 197, 196, 196),
                                          offset: Offset(2, 4),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/translation.png', // Ganti dengan path gambar Anda
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Translate',
                                            style: tFOnt(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
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
                          const SizedBox(
                            height: 20,
                          ),

                          // HISTORY Section
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'History',
                                  style: tFOnt(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HistoryVideo()));
                                  },
                                  child: Text(
                                    'View All',
                                    style: tFOnt(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              child: FutureBuilder<List<dynamic>>(
                                future: _history,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 50.0),
                                        child: Text(
                                          'You haven\'t started studying yet',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    List<dynamic> videoList = snapshot.data!
                                        .take(4)
                                        .toList(); // Limit to 4 items
                                    for (var video in videoList) {
                                      allVideos.add(Video(
                                        id: video['id'],
                                        name: video['name'],
                                        url: video['url'],
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: videoList.length,
                                      itemBuilder: (context, index) {
                                        final video = videoList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VideoPage(
                                                  id: video['id'],
                                                  idCategory:
                                                      video['id_category'],
                                                  video: allVideos,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 197, 196, 196),
                                                  offset: Offset(2, 4),
                                                  blurRadius: 5,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: SizedBox(
                                              width: 159.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/pidios.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: video[
                                                                        'category'] ==
                                                                    'LESSON'
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        252,
                                                                        163,
                                                                        133)
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        254,
                                                                        242,
                                                                        136),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: Text(
                                                              video['category'],
                                                              style: tFOnt(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Text(
                                                          video['name'],
                                                          maxLines: 1,
                                                          style: tFOnt(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // ARTICLE Section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Article',
                                style: tFOnt(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: ArticleData.articleData
                                    .map((e) => ArticleCard(
                                          data: e,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
