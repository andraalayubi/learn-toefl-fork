import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_toefl/models/video.dart';
import 'package:learn_toefl/services/video_service.dart';
import 'package:learn_toefl/utilities.dart';

class ListViewVideo extends StatefulWidget {
  final int subCategory;
  final String category;
  const ListViewVideo(
      {Key? key, required this.category, required this.subCategory})
      : super(key: key);

  @override
  State<ListViewVideo> createState() => _ListViewVideoState();
}

class _ListViewVideoState extends State<ListViewVideo> {
  late Future<List<VideoCategory>> _videoCategories;

  @override
  void initState() {
    super.initState();
    _videoCategories =
        fetchVideosByCategory(widget.category, widget.subCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: mColor,
        centerTitle: true,
        title: Text(
          widget.category,
          style: tFOnt(fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
      body: FutureBuilder<List<VideoCategory>>(
        future: fetchVideosByCategory(widget.category, widget.subCategory),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.category}'s Videos",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ...snapshot.data!
                        .map((videoCategory) => videoItem(videoCategory.videos))
                        .toList(),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget videoItem(List<Video> videos) {
    return Column(
      children: videos
          .map((video) => Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(14)),
                height: 90,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/pidios.png',
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        video.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.square_pencil,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _showUpdateDialog(context, video.id, widget.category,
                            video.name, video.url);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _showConfirmationDialog(context, video);
                      },
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

void _showConfirmationDialog(BuildContext context, Video video) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        content: Text(
          'Are you sure you want to delete this video?',
          style: tFOnt(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(width: 1.0, color: Colors.black)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: tFOnt(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 171, 52, 44),
                      border: Border.all(width: 1.0, color: Colors.black)),
                  child: TextButton(
                    onPressed: () async {
                      await deleteVideo(video.id);

                      showCustomSnackbar(
                        context,
                        '${video.name} Deleted!',
                        Colors.green,
                      );
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: Text(
                      'Delete',
                      style: tFOnt(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
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

void _showUpdateDialog(BuildContext context, int id, String category,
    String originalTitle, String originalUrl) {
  final titleController = TextEditingController(text: originalTitle);
  final urlController = TextEditingController(text: originalUrl);
  final categoryId = getCategoryID(category);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: mColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  'Update Videos',
                  style: tFOnt(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title of Material Video',
                            style: tFOnt(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: 'Input title',
                              hintStyle: tFOnt(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 214, 214, 214),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Link URL Video',
                            style: tFOnt(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: urlController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 214, 214, 214),
                              hintText: 'Input Link URL',
                              hintStyle: tFOnt(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: tFOnt(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              content: Text(
                                'Are you sure you want to add this video?',
                                style: tFOnt(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              actions: <Widget>[
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.black)),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: tFOnt(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: mColor,
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.black)),
                                        child: TextButton(
                                          onPressed: () async {
                                            await updateVideo(
                                              id,
                                              titleController.text,
                                              urlController.text,
                                              categoryId,
                                            );
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            showCustomSnackbar(
                                                context,
                                                'Video Updated Successfully',
                                                Colors.green);
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Confirm',
                                            style: tFOnt(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Update", style: tFOnt(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class AppBarCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 70);
    path.quadraticBezierTo(width / 2, height + 10, width, height - 70);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

int getCategoryID(String category) {
  switch (category.toLowerCase()) {
    case 'listening':
      return 1;
    case 'speaking':
      return 2;
    case 'reading':
      return 3;
    case 'writing':
      return 4;
    case 'subject & verb':
      return 5;
    case 'object':
      return 6;
    case 'tenses':
      return 7;
    default:
      throw Exception('Invalid category');
  }
}
