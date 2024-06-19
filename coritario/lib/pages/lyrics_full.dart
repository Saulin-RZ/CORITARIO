import 'package:flutter/material.dart';
import 'package:coritario/Style/colors.dart';
import 'package:coritario/Style/styles.dart';
import 'package:coritario/pages/lyrics.dart';

class LyricsFullPage extends StatefulWidget {
  final List<dynamic>? songs;
  final List<dynamic>? numbers;
  final List<dynamic>? titles;
  final List<dynamic>? lyrics;
  final List<dynamic>? chords;
  final dynamic index;

  const LyricsFullPage({
    Key? key,
    this.songs,
    this.numbers,
    this.titles,
    this.lyrics,
    this.chords,
    this.index,
  }) : super(key: key);

  @override
  _LyricsFullPageState createState() => _LyricsFullPageState();
}

class _LyricsFullPageState extends State<LyricsFullPage> {
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
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LyricsPage(
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
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 100),
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
