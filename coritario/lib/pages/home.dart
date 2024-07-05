import 'package:coritario/Style/colors.dart';
import 'package:coritario/Style/styles.dart';
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

  double _listTitlesFontSize = 25.0; // Initial font size for chords

  // Function to increase chords font size
  void _increaseFontSize() {
  setState(() {
    _listTitlesFontSize += 2.0; // Increase font size by 2 points
    if (_listTitlesFontSize > 25.0) { // Limit font size to 25 points
      _listTitlesFontSize = 25.0;
    }
  });
}

  // Function to decrease chords font size
  void _decreaseFontSize() {
    setState(() {
      _listTitlesFontSize -= 2.0; // Decrease font size by 2 points
      if (_listTitlesFontSize < 10.0) { // Ensure font size doesn't go below a certain limit
        _listTitlesFontSize = 10.0;
      }
    });
  }

  

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
      backgroundColor: myWhite,
      appBar: AppBar(
        backgroundColor: myPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
        ),
        leading: const Icon(
          Icons.search,
          color: myWhite, 
          size: 35, // Change the size of the icon
          ),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 60, right: 20, bottom: 10, top: 10),
              child: TextField(
                style: lightThemeTextFieldFilledStyle,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: 'Buscar',
                  hintStyle: lightThemeTextFieldEmptyStyle,
                    filled: true,
                    fillColor: myWhite,
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
      /*bottomNavigationBar: BottomAppBar(
        color: myPurple,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite, color: myWhite, 
              size: 35),
              onPressed: () {
                // Add functionality for the home button
              },
            ),
            IconButton(
              icon: const Icon(Icons.grid_on_rounded, color: myWhite, 
              size: 35),
              onPressed: () {
                // Add functionality for the search button
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: myWhite, 
              size: 35),
              onPressed: () {
                // Add functionality for the settings button
              },
            ),
          ],
        ),
      ),*/
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
                        color: myPurple, // Example: Apply purple color as background
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${numbers[songIndex]}',
                          style: lightThemeSideNumberStyle,
                        ),
                      ),
                    ),
 // Add prefix from the numbers list
                    const SizedBox(width: 8), // Add space between prefix and title
                    Text(
                      titles[songIndex],
                      style: lightThemeListTittlesStyle.copyWith(fontSize: _listTitlesFontSize),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Decrease Font Size Area
          GestureDetector(
            onTap: _decreaseFontSize,
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: myPurple.withOpacity(0.2), // Adjust opacity as needed
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: 30.0,
                  color: myPurple,
                ),
              ),
            ),
          ),
          // Increase Font Size Area
          GestureDetector(
            onTap: _increaseFontSize,
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: myPurple.withOpacity(0.2), // Adjust opacity as needed
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: myPurple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
