import 'dart:convert';
import 'package:http/http.dart' as http;

// Fungsi untuk mengambil data
Future<List<VideoCategory>> fetchVideos(int id) async {
  final response = await http.get(Uri.parse('http://192.168.0.119:3000/video/$id'));

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => VideoCategory.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load videos');
  }
}

class Video {
  final int id;
  final String name;

  Video({required this.id, required this.name});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class VideoCategory {
  final int id;
  final String name;
  final List<Video> videos;

  VideoCategory({required this.id, required this.name, required this.videos});

  factory VideoCategory.fromJson(Map<String, dynamic> json) {
    var list = json['videos'] as List;
    List<Video> videoList = list.map((i) => Video.fromJson(i)).toList();

    return VideoCategory(
      id: json['vid'] ?? 0,
      name: json['category_name'] ?? '',
      videos: videoList,
    );
  }
}