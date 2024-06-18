import 'package:coritario/logic/reader.dart';
import 'package:coritario/logic/word_search.dart';
import 'package:coritario/pages/lyrics.dart';
import 'package:flutter/material.dart';

/*
List<dynamic> readData = readerfunc();
List<dynamic> songs = readData[0];
List<dynamic> numbers = readData[1];
List<dynamic> titles = readData[2];
*/
class DataHolder {
  static List<dynamic>? songs;
  static List<dynamic>? numbers;
  static List<dynamic>? titles;
  static List<dynamic>? lyrics;
  static List<dynamic>? chords;
}

Future<void> loadData() async {
  List<dynamic> readData = await readerfunc();
  DataHolder.songs = readData[0];
  DataHolder.numbers = readData[1];
  DataHolder.titles = readData[2];
  DataHolder.lyrics = readData[3];
  DataHolder.chords = readData[4];
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> matchingIndices = [];

  @override
  Widget build(BuildContext context) {
    List<dynamic>? songs = DataHolder.songs;
    List<dynamic>? numbers = DataHolder.numbers;
    List<dynamic>? titles = DataHolder.titles;
    List<dynamic>? lyrics = DataHolder.lyrics;
    List<dynamic>? chords = DataHolder.chords;

    if (songs == null || numbers == null || titles == null) {
      // Handle the case where data is not yet loaded
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Or any other loading indicator
        ),
      );
    }

    // If there is no search input, show all songs
    List<int> displayedIndices = matchingIndices.isEmpty ? List.generate(titles.length, (index) => index) : matchingIndices;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 243, 255, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 111, 255, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
        ),
        leading: const Icon(
          Icons.search,
          color: Color.fromRGBO(240, 243, 255, 1), 
          size: 35, // Change the size of the icon
          ),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 60, right: 20, bottom: 10, top: 10),
              child: TextField(
                style: const TextStyle(
                    color:  Color.fromRGBO(33, 25, 81, 1) 
                  ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: 'Buscar',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(178, 180, 186, 1)
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(240, 243, 255, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide.none
                    ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    matchingIndices = keyWordSearch(value, songs);
                  });
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(131, 111, 255, 1),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Color.fromRGBO(240, 243, 255, 1), 
              size: 35),
              onPressed: () {
                // Add functionality for the home button
              },
            ),
            IconButton(
              icon: const Icon(Icons.grid_on_rounded, color: Color.fromRGBO(240, 243, 255, 1), 
              size: 35),
              onPressed: () {
                // Add functionality for the search button
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Color.fromRGBO(240, 243, 255, 1), 
              size: 35),
              onPressed: () {
                // Add functionality for the settings button
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: List.generate(
          displayedIndices.length,
          (index) {
            int songIndex = displayedIndices[index];
            return GestureDetector(
              onTap: () {
                // Handle click action here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LyricsPage(
                    songs: songs, 
                    numbers: numbers, 
                    titles: titles, 
                    lyrics: lyrics, 
                    chords: chords, 
                    index: songIndex,
                  )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 8), // Add left padding
                child: Row(
                  children: [
                    Container(
                      width: 30, // Increase the width of the container
                      height: 30, // Increase the height of the container
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(131, 111, 255, 1), // Example: Apply blue color as background
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9.5, top: 0),
                        child: Text(
                          '${numbers[songIndex]}',
                          style: const TextStyle(
                            color: Color.fromRGBO(245, 246, 250, 1),
                            fontSize: 19.5 // Example: Apply white color for text
                          ),
                        ),
                      ),
                    ), // Add prefix from the numbers list
                    const SizedBox(width: 8), // Add space between prefix and title
                    Text(
                      titles[songIndex],
                      style: const TextStyle(
                        fontStyle: FontStyle.italic, // Example: Apply italic style
                        color: Color.fromRGBO(131, 111, 255, 1),
                        fontSize: 25 // Example: Apply red color
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
