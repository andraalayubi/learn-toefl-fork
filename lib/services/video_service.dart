import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_toefl/ip.dart';

Future<void> addNewVideo(String title, String url, int categoryId) async {
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

Future<void> updateVideo(int id, String name, String url, int categoryId) async {
  final response = await http.put(
    Uri.parse('http://localhost:3000/video/update/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'url': url,
      'categoryId': categoryId,
    }),
  );

  if (response.statusCode == 308) {
    // Handle permanent redirect
    final redirectLocation = response.headers['location'];
    final redirectUri = Uri.parse(redirectLocation!);
    Uri newUri;

    if (redirectUri.hasScheme) {
      newUri = redirectUri;
    } else {
      newUri = Uri.parse('http://localhost:3000').resolveUri(redirectUri);
    }

    print('Redirect location: $newUri');

    final redirectedResponse = await http.put(
      newUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'url': url,
        'categoryId': categoryId,
      }),
    );

    if (redirectedResponse.statusCode == 200) {
      print('Video updated successfully');
    } else {
      throw Exception('Failed to update video after redirect');
    }
  } else if (response.statusCode == 200) {
    print('Video updated successfully');
  } else {
    print('Error: ${response.body}');
  }
}

Future<void> deleteVideo(int id) async {
  final response = await http.delete(
    Uri.parse('http://localhost:3000/video/delete/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 308) {
    // Handle permanent redirect
    final redirectLocation = response.headers['location'];
    final redirectUri = Uri.parse(redirectLocation!);
    Uri newUri;

    if (redirectUri.hasScheme) {
      newUri = redirectUri;
    } else {
      newUri = Uri.parse('http://localhost:3000').resolveUri(redirectUri);
    }

    print('Redirect location: $newUri');

    final redirectedResponse = await http.delete(
      newUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (redirectedResponse.statusCode == 200) {
      print('Video deleted successfully');
    } else {
      throw Exception('Failed to delete video after redirect');
    }
  } else if (response.statusCode == 200) {
    print('Video deleted successfully');
  } else {
    print('Error: ${response.body}');
  }
}