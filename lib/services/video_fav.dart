import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VideoFav {
  static const String _favKey = 'video_fav';
  static Future<bool> isFavorite(int videoId) async {
    try {
      List<dynamic> favorites = await getFavs();
      return favorites.any((video) => video['id'] == videoId);
    } catch (e) {
      print('Error checking favorite status: $e');
      return false;
    }
  }

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

  static Future<List<dynamic>> getFavs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> videoFavorite = prefs.getStringList(_favKey) ?? [];

    return videoFavorite.map((videoJson) => jsonDecode(videoJson)).toList();
  }
}
