import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bloc_example/model.dart';

class ApiRepository {
  
  Future<List<AlbumModel>?> fetchPost() async {
  try {
     final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    final parsed= json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<AlbumModel>((json) => AlbumModel.fromJson(json)).toList();
  } else {
    
    throw Exception('Failed to load Post');
  }
  } catch (e) {
   log(e.toString()); 
  }
 
}
}