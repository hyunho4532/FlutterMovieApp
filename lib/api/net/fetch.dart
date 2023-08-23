import 'dart:convert';
import 'package:http/http.dart' as http;

fetch(String pathname, Map<String, String> qs) async {
  String host = 'www.kobis.or.kr';
  qs [ 'key' ] = '79087d2a1af27f32f2300b1619a278d8';
  var response = await http.get(Uri.https(host, pathname, qs));
  return jsonDecode(response.body);
}