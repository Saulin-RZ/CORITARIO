import 'package:flutter/material.dart';
import 'package:coritario/Style/colors.dart';
import 'package:coritario/Style/styles.dart';
import 'package:coritario/pages/chords.dart';
import 'package:coritario/pages/home.dart';
import 'package:coritario/pages/lyrics_full.dart';

class LyricsPage extends StatefulWidget {
  final List<dynamic>? songs;
  final List<dynamic>? numbers;
  final List<dynamic>? titles;
  final List<dynamic>? lyrics;
  final List<dynamic>? chords;
  final dynamic index;

  const LyricsPage({
    Key? key,
    this.songs,
    this.numbers,
    this.titles,
    this.lyrics,
    this.chords,
    this.index,
  }) : super(key: key);

  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  late dynamic _currentIndex;
  double _lyricsFontSize = 26.0; // Initial font size for lyrics

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  // Function to increase lyrics font size
  void _increaseFontSize() {
    setState(() {
      _lyricsFontSize += 2.0; // Increase font size by 2 points
    });
  }

  // Function to decrease lyrics font size
  void _decreaseFontSize() {
    setState(() {
      _lyricsFontSize -= 2.0; // Decrease font size by 2 points
      if (_lyricsFontSize < 10.0) { // Ensure font size doesn't go below a certain limit
        _lyricsFontSize = 10.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        backgroundColor: myPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: myWhite, size: 35),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90, bottom: 10, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: myWhite,
                        borderRadius: BorderRadius.circular(100), // Adjust the radius as needed
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.numbers![_currentIndex]}',
                        style: lightThemeTopNumberStyle,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: myPurple, size: 35),
                  onPressed: () {
                    // Add functionality for the favorite button

                    //NOTE: Change color back to myWhite when implemented
                  },
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: myPurple,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.text_decrease_rounded, color: myWhite, size: 35),
              onPressed: _decreaseFontSize,
            ),
            IconButton(
              icon: const Icon(Icons.music_note, color: myWhite, size: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChordsPage(
                      songs: widget.songs,
                      numbers: widget.numbers,
                      titles: widget.titles,
                      lyrics: widget.lyrics,
                      chords: widget.chords,
                      index: _currentIndex,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.text_increase_rounded, color: myWhite, size: 35),
              onPressed: _increaseFontSize,
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LyricsFullPage(
                songs: widget.songs,
                numbers: widget.numbers,
                titles: widget.titles,
                lyrics: widget.lyrics,
                chords: widget.chords,
                index: _currentIndex,
              ),
            ),
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                '${widget.titles![_currentIndex]}\n\n${widget.lyrics![_currentIndex]}',
                style: lightThemeLyricsStyle.copyWith(fontSize: _lyricsFontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
