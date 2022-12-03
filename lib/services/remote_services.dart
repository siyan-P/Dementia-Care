import 'dart:developer';

import 'package:flutter_application_4/API/Models_symp.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Post>?> getPost() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      log("API connection successfull!");
      var json = response.body;
      return postFromJson(json);
    }
  }
}
