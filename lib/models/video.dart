import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:learn_toefl/ip.dart';

// Fungsi untuk mengambil data
Future<List<VideoCategory>> fetchVideos(int id) async {
  final response = await http.get(Uri.parse('$ip/video/all/$id'));

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => VideoCategory.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load videos');
  }
}

Future<List<VideoCategory>> fetchVideosByCategory(String category, int subCategory) async {
  final response = await http.get(Uri.parse('$ip/video/all/$subCategory'));
  // final response = await http.get(Uri.parse('http://localhost:3000/video/all/1'));

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    List<VideoCategory> allVideos =
        list.map((model) => VideoCategory.fromJson(model)).toList();

    // Filter video categories based on the given category
    List<VideoCategory> filteredVideos = allVideos
        .where((videoCategory) => videoCategory.name == category)
        .toList();

    return filteredVideos;
  } else {
    throw Exception('Failed to load videos');
  }
}

Future<Video> getDataVideo(int id) async {
  final response = await http.get(Uri.parse('$ip/video/$id'));

  if (response.statusCode == 200) {
    return Video.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load videos');
  }
}

class Video {
  final int id;
  final String name;
  final String url;

  Video({required this.id, required this.name, required this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
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