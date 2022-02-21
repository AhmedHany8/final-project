import 'dart:convert';

import 'package:http/http.dart' as http;



Future<Map<String,dynamic>> postData(String base64) async {
  Map<String,String> imgMap = {"imgstr": base64};
  const String url = 'http://172.20.10.3:5000/api';
  http.Response response = await http.post(Uri.parse(url),
      body: jsonEncode(imgMap), headers: {"Content-Type": "application/json"});
  
  return json.decode(response.body);
}
