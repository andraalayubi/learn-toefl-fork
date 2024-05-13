import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_toefl/database/video_history.dart';
import 'package:learn_toefl/utilities.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late Future<List<dynamic>> _history;

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
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(right: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 160,
        child: Expanded(
          child: FutureBuilder<List<dynamic>>(
              future: _history,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Text('You haven`t started studying yet', style: GoogleFonts.poppins(fontStyle: FontStyle.italic),);
                } else {
                  // return Text('Berhasil');
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final video = snapshot.data![index];
                      print(video);
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 197, 196, 196),
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: SizedBox(
                            width: 159.2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/video.png', // Ganti dengan path gambar Anda
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          4), // Tambahkan widget SizedBox untuk memberi jarak
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 174, 148),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            video['category'],
                                            style: tFOnt(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              2), // Tambahkan widget SizedBox untuk memberi jarak
                                      Text(
                                        video['name'],
                                        maxLines: 1,
                                        style: tFOnt(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
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
              }),
        ),
      ),
    );
  }
}
