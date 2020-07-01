import 'dart:convert';
import 'package:favorite_youtube/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyCPfdQwrO4Dsr4Boi7o4YZc15_O7jZVSQM";

class Api {
   
  search(String search) async {
    http.Response response = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );

    return decode(response);

  }

  List<Video> decode(http.Response response) {

    if(response.statusCode == 200) {

      var decoded = json.decode(response.body);

      List<Video> videos = decoded['itens'].map(
        (map) {
          return Video.fromJson(map);
        }
      ).toList();

      return videos;
      
    } else {
      throw Exception("Failed to load videos, try again!");
    }
  }

}