import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UnsplashService {
  static final _accessKey = dotenv.env['UNSPLASH_ACCESS_KEY'];

  static Future<String?> getImage(List<String> tags) async {
    if (DateTime.now().millisecondsSinceEpoch % 5 < 2) return null;

    final query = tags.isNotEmpty ? tags.join(',') : 'people,city,technology';

    final url = Uri.parse(
      'https://api.unsplash.com/photos/random'
      '?query=$query&orientation=landscape&client_id=$_accessKey',
    );

    final res = await http.get(url);
    if (res.statusCode == 200) {
      return json.decode(res.body)['urls']['regular'];
    }
    return null;
  }
}
