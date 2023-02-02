import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTPhelper {
  // -->fetch all data from api
  Future<List<Map>> fetchItems(String token) async {
    List<Map> items = [];
    //get datas from api _creating connection
    http.Response response = await http.get(
        Uri.parse('https://dementia.cianlogic.com/symptom/list'),
        headers: {
          'Authorization': token,
          //'Content-Type': 'application/json'
        });
    log(token);
    if (response.statusCode == 200) {
      log("API connection succssfull-->for listing all data");
      //get the data from responce
      String jsonString = response.body;
      //convert to List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();
      log(jsonString);
    } else {
      log("API connection faild-->for listing all data");
    }

    return items;
  }

  //-->fetch details of one data using cards id
  // Future<Map> getItem(String token) async {
  //   log(id);
  //   Map item = {};
  //   //get the item from api
  //   http.Response response =
  //       await http.get(Uri.parse('https://dementia.cianlogic.com/symptom/$id'),
  //       headers: {
  //         'Authorization': token,
  //         //'Content-Type': 'application/json'
  //       });
  //   if (response.statusCode == 200) {
  //     //get the data from responce body
  //     String jsonString = response.body;
  //     //convert to List<Map>
  //     item = jsonDecode(jsonString);
  //   }
  //   return item;
  // }

  //-->delete an item
  Future<bool> deleteItem(String itemid) async {
    bool status = false;
    //delete item from the database
    http.Response response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemid'));
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }

  //-->add a new item list into the database
  Future<bool> addItem(Map data) async {
    bool status = false;
    //add the data to the database
    http.Response response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 201) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  //-->update an item list
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;
    //update the listed(itemId) item
    http.Response response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }
}
