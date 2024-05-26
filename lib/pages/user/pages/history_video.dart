import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/services/video_history.dart';
import 'package:learn_toefl/models/video.dart';

class HistoryVideo extends StatefulWidget {
  const HistoryVideo({Key? key}) : super(key: key);

  @override
  State<HistoryVideo> createState() => _HistoryVideoState();
}

class _HistoryVideoState extends State<HistoryVideo> {
  late List<dynamic> _history = []; // Inisialisasi _history sebagai List<dynamic>
  List<Video> allVideos = [];

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  void fetchHistory() async {
    var videoHistory = await VideoHistory.getHistory();
    print('videoHistory $videoHistory');
    setState(() {
      _history = videoHistory;
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
              const SizedBox(
                height: 25,
              ),
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
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      final historyItem = _history[index];
                      final String category = historyItem['category'] ?? '';
                      final String videoName = historyItem['name'] ?? '';

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/video.png'),
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
                                      color: const Color.fromRGBO(
                                          0xFF, 0x86, 0x5F, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12),
                                    child: Text(
                                      category,
                                      style: TextStyle(
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
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
