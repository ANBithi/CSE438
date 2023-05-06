import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Helpers/read_data.dart';

class ResultService {
  static const _baseUrl = "http://localhost:5000/api/result";
  static Future<dynamic> addResult(Map<dynamic, dynamic> request) async {
    final response = await http.post(Uri.parse('$_baseUrl/add'),
        headers: {...await authHeader(), 'Content-Type': 'application/json'},
        body: jsonEncode(request));
    return jsonDecode(response.body);
  }

  static Future<dynamic> getResults() async {
    final response = await http.get(Uri.parse('$_baseUrl/getAll'),
        headers: {...await authHeader(), 'Content-Type': 'application/json'});
    return jsonDecode(response.body);
  }

  static Future<dynamic> getResult(String userId, String courseCode) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/getSingle?belongsTo=$userId&type=$courseCode'),
        headers: {...await authHeader(), 'Content-Type': 'application/json'});
    return jsonDecode(response.body);
  }
}
