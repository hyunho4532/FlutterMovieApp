import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MovieProvider extends GetConnect {

  final String apiKey = 'AIzaSyAVh6EJfIumU7Os1NEgxTI_CjUyLxNxPOc';

  Future<Response> getPlaceId(String input) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$apiKey';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'];


    return placeId;
  }
}