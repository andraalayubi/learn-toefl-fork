import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VideoHistory {
  static const String _historyKey = 'video_history';

  static Future<void> addHistory(
      int id, String name, int id_category, String category, String url) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> videoHistory = prefs.getStringList(_historyKey) ?? [];

    // Create a map to store the video id and name
    Map<String, dynamic> videoMap = {
      'id': id,
      'name': name,
      'id_category': id_category,
      'category': category,
      'url': url,
    };

    // Convert the map to a JSON string
    String videoJson = jsonEncode(videoMap);

    // Remove video if it's already in the history to avoid duplicates
    videoHistory.remove(videoJson);

    // Add video to the beginning of the list
    videoHistory.insert(0, videoJson);

    // Limit the history to 5 videos
    // while (videoHistory.length > 5) {
    //   videoHistory.removeLast();
    // }

    await prefs.setStringList(_historyKey, videoHistory);
  }

  static Future<List<dynamic>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> videoHistory = prefs.getStringList(_historyKey) ?? [];

    // Convert the list of JSON strings back to a list of maps
    return videoHistory.map((videoJson) => jsonDecode(videoJson)).toList();
  }
}
