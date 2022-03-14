import 'dart:convert';
import 'package:http/http.dart';

// {
//   "data": [
//     {
//       "id": "db3d35669c5e11ecaf76cf4569db73f3",
//       "mime_type": "text/plain",
//       "text": "hell"
//     }
//   ],
//   "targetExecutor": "",
//   "parameters": {"limit" : 5}
// }

makePostRequest() async {
  final uri = Uri.parse('http://192.168.1.9:12345/search');
  final headers = {'Content-Type': 'application/json'};
  var final_data = [];
  Map<String, dynamic> body = {
    "data": [
      {"text": "comedy"}
    ],
    "parameters": {"limit": 10}
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;
  print(statusCode);
  var convertedData = jsonDecode(responseBody);
  final_data = convertedData['data'][0]['matches'];

  for (var item in final_data) {
    print(item['tags']['Title']);
  }
}

void main(List<String> arguments) {
  print("Starting");
  makePostRequest();
}
