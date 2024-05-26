import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_toefl/ip.dart';

Future<void> insertNilai(int questionId, int userId, int nilai) async {
  final url = Uri.parse('$ip/nilai'); // Ganti dengan URL server yang sesuai

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'question_id': questionId,
      'user_id': userId,
      'nilai': nilai,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data['message']); // Mencetak pesan sukses
  } else {
    print('Terjadi kesalahan: ${response.statusCode}');
  }
}