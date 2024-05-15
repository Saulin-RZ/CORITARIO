import 'package:coritario/pages/chords.dart';
import 'package:flutter/material.dart';




class ChordsFullPage extends StatelessWidget {
  
  final List<dynamic>? songs;
  final List<dynamic>? numbers;
  final List<dynamic>? titles;
  final List<dynamic>? lyrics;
  final List<dynamic>? chords;
  final dynamic index;
  

  const ChordsFullPage({super.key, this.songs, this.numbers, this.titles, this.lyrics, this.chords, this.index});

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 243, 255, 1),
      body: GestureDetector(
        onTap: () {
          // Add your desired action here
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChordsPage(songs: songs, numbers: numbers, titles: titles, lyrics: lyrics, chords: chords, index: index,)));
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
                  fontSize: 22, // Example: Apply white color for text
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      )

      );
  }
}

