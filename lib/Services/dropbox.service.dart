import 'dart:convert';
import 'package:http/http.dart' as http;

const ACCESS_KEY =
    "sl.BdyVLNWoFzRCwY4TsT5NsFaGx4bcd-_igCqhyZ1dN4C0w_JtTR5KCCEtdxgq3CZ9ZMawllWvW4CzpprxJWxCZrRkjX9l31Nomil-Y1KK2RE-l0DIv4B1Kg9RgobyUDERYAYQ_09P";
const APP_KEY_AND_SECRET = "MDN5c3lmandzbmV6cGs3OjU2cG5qdmFkOGRxYWFmZQ==";

Future<dynamic> checkDropBox() async {
  final url = Uri.parse('https://api.dropboxapi.com/2/check/app');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $APP_KEY_AND_SECRET',
  };
  final body = jsonEncode({'query': 'foo'});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to check DropBox');
  }
}

Future<void> uploadFile(String path, dynamic file) async {
  final fileUploadArgs = {
    "autorename": false,
    "mode": "add",
    "mute": false,
    "path": path,
    "strict_conflict": false
  };

  final response = await http.post(
      Uri.parse("https://content.dropboxapi.com/2/files/upload"),
      headers: {
        "Content-Type": "application/octet-stream",
        "Authorization": "Bearer $ACCESS_KEY",
        "Dropbox-API-Arg": json.encode(fileUploadArgs)
      },
      body: file);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data;
  } else {}
}

Future<Map<String, dynamic>> createSharedLink(String path) async {
  var request = {
    "path": path,
    "settings": {
      "access": "viewer",
      "allow_download": true,
      "audience": "public",
      "requested_visibility": "public"
    }
  };

  var response = await http.post(
    Uri.parse(
        "https://api.dropboxapi.com/2/sharing/create_shared_link_with_settings"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $ACCESS_KEY"
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    return {
      "url": responseBody['url'],
      "preview_type": responseBody['preview_type']
    };
  } else {
    throw Exception('Failed to create shared link');
  }
}

Future<Map<String, dynamic>> getFileRequest() async {
  final request = {"id": "id:VNJRS_gui-oAAAAAAAAADg"};
  final response = await http.post(
    Uri.parse("https://api.dropboxapi.com/2/file_requests/get"),
    headers: {
      "Authorization": "Bearer $ACCESS_KEY",
      "Content-Type": "application/json",
      "Dropbox-API-Arg": jsonEncode(request),
    },
  );
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    throw Exception("Failed to get file request");
  }
}
