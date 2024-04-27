
import 'package:learn_toefl/database/toefl_database.dart';

Future<Map<String, dynamic>> fetchVideoData(int id) async {
  try {
    final db = await ToeflDatabase.instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM Video WHERE id = ?', [id]);
    return result.first;
  } catch (e) {
    throw Exception('Error fetching video data: $e');
  }
}
