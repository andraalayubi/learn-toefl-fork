import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_toefl/ip.dart';

Future<void> addNewVideo(
    String title, String url, int categoryId) async {
  // final uri = Uri.parse('http://localhost:3000/video/add');
  final uri = Uri.parse('$ip/video/add');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': title,
      'url': url,
      'categoryId': categoryId,
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
      newUri = uri.resolveUri(redirectUri);
    }

    print('Redirect location: $newUri');

    final redirectedResponse = await http.post(
      newUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': title,
        'url': url,
        'categoryId': categoryId,
      }),
    );

    if (redirectedResponse.statusCode == 200) {
      print('Video added successfully: ${response.body}');
    } else {
      print(redirectedResponse.statusCode);
      throw Exception('Video add failed after redirect');
    }
  } else if (response.statusCode == 200) {
    // Video berhasil ditambahkan
    print('Video added successfully: ${response.body}');
  } else {
    // Terjadi kesalahan saat menambahkan video
    print('Error adding video: ${response.body}');
  }
}
