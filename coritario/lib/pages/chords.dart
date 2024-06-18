import 'package:coritario/pages/chords_full.dart';
import 'package:coritario/pages/home.dart';
import 'package:coritario/pages/lyrics.dart';
import 'package:flutter/material.dart';




class ChordsPage extends StatelessWidget {
  
  final List<dynamic>? songs;
  final List<dynamic>? numbers;
  final List<dynamic>? titles;
  final List<dynamic>? lyrics;
  final List<dynamic>? chords;
  final dynamic index;
  

  const ChordsPage({super.key, this.songs, this.numbers, this.titles, this.lyrics, this.chords, this.index});

  

  @override
  Widget build(BuildContext context) {

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
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(240, 243, 255, 1), 
              size: 35),
              onPressed: () {
                // Add functionality for the search button
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            Expanded(
  child: Padding(
    padding: const EdgeInsets.only(left: 90, right: 90, bottom: 10, top: 10),
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(240, 243, 255, 1),
        borderRadius: BorderRadius.circular(100), // Adjust the radius as needed
      ),
      alignment: Alignment.center,
      
        
        child: Text(
          '${numbers![index]}',
          style: const TextStyle(
            color: Color.fromRGBO(178, 180, 186, 1),
            fontSize: 30 // Change text color to ensure visibility
          ),
        ),
      
    ),
  ),
),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Color.fromRGBO(240, 243, 255, 1), 
              size: 35),
              onPressed: () {
                // Add functionality for the search button
              },
            ),
          ],
        ),
      )
      ]
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(131, 111, 255, 1),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.music_off, color: Color.fromRGBO(240, 243, 255, 1), 
              size: 35),
              onPressed: () {
                // Add functionality for the search button
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LyricsPage(songs: songs, numbers: numbers, titles: titles, lyrics: lyrics, chords: chords, index: index,)));
              },
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Add your desired action here
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChordsFullPage(songs: songs, numbers: numbers, titles: titles, lyrics: lyrics, chords: chords, index: index,)));
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                '${titles![index]}\n\n${chords![index]}',
                style: const TextStyle(
                  color: Color.fromRGBO(131, 111, 255, 1),
                  fontSize: 26, // Example: Apply white color for text
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      )

      );
  }
}

