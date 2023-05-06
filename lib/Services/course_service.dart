import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Helpers/read_data.dart';

Future<Map<String, dynamic>> fetchAllSections() async {
  String url = 'http://localhost:5000/api/section/getAllSections';
  http.Response response = await http.get(
    Uri.parse(url),
    headers: await authHeader(),
  );
  var data = json.decode(response.body);
  return data;
}
