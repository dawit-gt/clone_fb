import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/post_model.dart';

class ApiService {
  static Future<List<UserModel>> fetchUsers() async {
    final res = await http.get(
      Uri.parse('https://dummyjson.com/users?limit=100'),
    );
    final data = json.decode(res.body);
    return (data['users'] as List).map((e) => UserModel.fromJson(e)).toList();
  }

  static Future<List<PostModel>> fetchPosts(int skip, int limit) async {
    final res = await http.get(
      Uri.parse('https://dummyjson.com/posts?limit=$limit&skip=$skip'),
    );
    final data = json.decode(res.body);
    return (data['posts'] as List).map((e) => PostModel.fromJson(e)).toList();
  }
}
