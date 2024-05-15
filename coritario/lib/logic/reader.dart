import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<dynamic>> readerfunc() async {
  try {
    // Load the JSON content using rootBundle
    String jsonContent = await rootBundle.loadString('assets/lyrics.json');

    // Parse the JSON content into a Map
    Map<String, dynamic> data = jsonDecode(jsonContent);

    // Extract the list of songs
    List<dynamic> songs = data['songs'];

    // Initialize lists to store numbers and titles
    List<int> songNumbers = [];
    List<String> songTitles = [];
    List<String> songLyrics = [];
    List<String> songChords = [];

    // Loop through the songs and extract numbers and titles
    for (var i = 0; i < songs.length; i++) {
      var song = songs[i];
      songNumbers.add(song['number']);
      songTitles.add(song['title']);
      songLyrics.add(song['lyrics_without_chords']);
      songChords.add(song['lyrics_with_chords']);
    }

    // Return a list containing songs, numbers, and titles
    return [songs, songNumbers, songTitles, songLyrics, songChords];
  } catch (e) {
    // Handle any exceptions (e.g., file not found, JSON decoding error)
    //print('Error loading asset: $e');
    return [];
  }
}
