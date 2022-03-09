import 'dart:convert';
import 'package:flutter_application_1/data.dart';
import 'package:http/http.dart' as http;

class Service {
  static Future getAllData() async {
    http.Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
    var responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List data = responseMap.map<Data>((data) => Data.fromJson(data)).toList();
      return data;
    } else {
      return [];
    }
  }
}
