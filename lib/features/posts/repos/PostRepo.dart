import 'dart:convert';

import 'package:flutter_bloc_sample/features/posts/models/posts_data_ui_model.dart';
import 'package:http/http.dart' as http;

import '../bloc/posts_bloc.dart';

class PostRepo {
  static Future<List<PostDataUiModel>> fetchPost() async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      List<dynamic> jsonResponse = jsonDecode(response.body);

      // Ensure the decoded JSON is a List
      List<PostDataUiModel> posts = jsonResponse
          .map((postJson) => PostDataUiModel.fromMap(postJson))
          .toList();

      // print(posts);
      // emit(PostsFetchSuccessfulState(posts: posts));
      return posts;
    } catch (e) {
      // emit(PostsFetchErrorState());
      // print('Error fetching posts: $e');
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        'title': 'title from nottu',
        'body': 'body from nottu',
        'userId': '12',
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
