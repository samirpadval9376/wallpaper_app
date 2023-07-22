import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/modals/post_modal.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  String api = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Posts>?> getMultipleResponse() async {
    http.Response response = await http.get(
      Uri.parse(api),
    );

    List allData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Posts> allPosts =
          allData.map((e) => Posts.fromMap(data: e)).toList();

      return allPosts;
    }
  }

  wallpaper({String query = "nature"}) async {
    String wallpaperApi =
        "https://pixabay.com/api/?key=38361528-43672cfcd8509ef1ba648f7c3&q=$query&orientation=vertical";
    http.Response response = await http.get(
      Uri.parse(wallpaperApi),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List allData = data['hits'];

      return allData;
    }
  }
}
