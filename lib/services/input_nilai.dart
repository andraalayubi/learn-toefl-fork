import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_toefl/ip.dart';

Future<void> insertNilai(int questionId, int userId, int nilai) async {
  final url = Uri.parse('$ip/nilai'); // Ganti dengan URL server yang sesuai
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'question_id': questionId,
        'user_id': userId,
        'nilai': nilai,
      }),
    );

    if (response.statusCode == 308) {
      print('Redirect detected with status code 308');
      final redirectLocation = response.headers['location'];

      // Check if the redirect location is relative
      final redirectUri = Uri.parse(redirectLocation!);
      Uri newUri;

      if (redirectUri.hasScheme) {
        // Absolute URI
        newUri = redirectUri;
      } else {
        newUri = url.resolveUri(redirectUri);
      }

      print('Redirect location: $newUri');

      final redirectedResponse = await http.post(
        newUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'question_id': questionId,
          'user_id': userId,
          'nilai': nilai,
        }),
      );

      if (redirectedResponse.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['message']); // Mencetak pesan sukses
      } else {
        print(redirectedResponse.statusCode);
        throw Exception('Failed to login after redirect');
      }
    } else if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['message']); // Mencetak pesan sukses
    } else {
      print('Terjadi kesalahan: ${response.statusCode}');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}
