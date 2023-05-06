import 'dart:convert';

import '../Helpers/read_data.dart';
import 'package:http/http.dart' as http;

Future<bool> addPost(Map<dynamic, dynamic> post) async {
  Map<String, dynamic> user = await readUserStorageData();
  Map<String, dynamic> request = {...post, 'creatorType': user['userType']};

  final response = await http.post(
    Uri.parse('http://localhost:5000/api/post/add'),
    headers: {...await authHeader(), 'Content-Type': 'application/json'},
    body: json.encode(request),
  );
  return json.decode(response.body);
}

Future getAllPost(String belongsTo) async {
  final response = await http.get(
    Uri.parse("http://localhost:5000/api/post/getAll?belongsTo=$belongsTo"),
    headers: {...await authHeader(), "Content-Type": "application/json"},
  );
  var data = json.decode(response.body);
  return data;
}

Future<dynamic> getAllComments(String parentId) async {
  final response = await http.get(
      Uri.parse(
          'http://localhost:5000/api/post/getAllComments?parentId=$parentId'),
      headers: {...await authHeader(), "Content-Type": "application/json"});
  var data = json.decode(response.body);
  return data;
}

Future postComment(Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api/post/postComment'),
    headers: {...await authHeader(), 'Content-Type': 'application/json'},
    body: jsonEncode(request),
  );

  var data = json.decode(response.body);
  return data;
}

Future<bool> addReaction(Map<String, dynamic> reaction) async {
  final response = await http.post(
      Uri.parse('http://localhost:5000/api/post/addReaction'),
      headers: {...await authHeader(), 'Content-Type': 'application/json'},
      body: json.encode(reaction));

  var data = json.decode(response.body);
  return data;
}

Future<dynamic> getAllReactions(String parentId) async {
  final url = Uri.parse(
      'http://localhost:5000/api/post/getAllReactions?parentId=$parentId');
  final response = await http.get(url, headers: {
    ...await authHeader(),
    "Content-Type": "application/json",
    // add any required headers here
  });
  var data = json.decode(response.body);
  return data;
}
