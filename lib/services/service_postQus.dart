// import '../API/Models_qus.dart';
// import 'package:http/http.dart' as http;
// import 'dart:developer';

// class RemoteServiceQus {
//   Future<List<Post>?> postqus() async {
//     try {
//       var client = http.Client();
//       var uri = Uri.parse('https://dummyjson.com/quotes');
//       var response = await client.get(uri);
//       if (response.statusCode == 200) {
//         log("API connection successfull!");
//         var json = response.body;
//         // print("Data from api-->question $json");
//         return postFromJson(json);
//       }
//     } catch (exeption) {}
//     return null;
//   }
// }
