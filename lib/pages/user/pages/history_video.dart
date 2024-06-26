import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/pages/user/pages/video.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/services/video_history.dart';
import 'package:learn_toefl/models/video.dart';

class HistoryVideo extends StatefulWidget {
  const HistoryVideo({Key? key}) : super(key: key);

  @override
  State<HistoryVideo> createState() => _HistoryVideoState();
}

class _HistoryVideoState extends State<HistoryVideo> {
  late List<dynamic> _history =
      []; // Inisialisasi _history sebagai List<dynamic>
  List<Video> allVideos = [];

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  void fetchHistory() async {
    var videoHistory = await VideoHistory.getHistory();
    setState(() {
      _history = videoHistory;
      for (var video in _history) {
        allVideos.add(Video(
          id: video['id'],
          name: video['name'],
          url: video['url'],
        ));
      }
    });
  }

  void _deleteHistoryItem(int index) async {
    final int videoId = _history[index]['id'];
    await VideoHistory.removeHistory(videoId);

    setState(() {
      _history.removeAt(index);
      allVideos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'HISTORY',
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 10),
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
                          borderRadius: BorderRadius.circular(12),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Take a look back at your viewed videos.',
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
                                'assets/images/watching.png',
                                width: 155,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 26.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All History',
                            style: tFOnt(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: _history.isEmpty
              ? Center(
                  child: Text(
                    'No History Available',
                    style: tFOnt(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final historyItem = _history[index];
                    final String category = historyItem['category'] ?? '';
                    final String videoName = historyItem['name'] ?? '';

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPage(
                                id: historyItem['id'],
                                idCategory: historyItem['id_category'],
                                video: allVideos,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(width: 1.0, color: Colors.black),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/pidios.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: category == 'LESSON'
                                          ? const Color.fromARGB(
                                              255, 252, 163, 133)
                                          : const Color.fromARGB(
                                              255, 254, 242, 136),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12),
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    videoName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showConfirmationDialog(
                                    context, index, historyItem);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Ubah sesuai kebutuhan
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          content: Text(
            'Are you sure you want to delete this video from history?',
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
                  'Cancel',
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
                  _deleteHistoryItem(index);
                  Navigator.of(context).pop();
                  showCustomSnackbar(
                    context,
                    '${video['name']} Deleted From History!',
                    Colors.green,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
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
}
