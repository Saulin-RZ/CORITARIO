//import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'package:path/path.dart' as p;
//import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:flutter/services.dart' show rootBundle;

List<dynamic> readerfunc() {
 
  // WORKING
  String jsonContent = File('assets/lyrics.json').readAsStringSync();

  // Parse the JSON content into a Map
  Map<String, dynamic> data = jsonDecode(jsonContent);

  // Extract the list of songs
  List<dynamic> songs = data['songs'];

  final numbers = [];
  final titles = [];
  


  for (var i = 0; i < songs.length; i++) {
    var song = songs[i];
    numbers.add(song['number']);
    titles.add(song['title']);
  }

  return [songs, numbers, titles];
  

}
