import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coritario/pages/home.dart';
import 'utils/fullscreen_controller_stub.dart'
if (dart.library.ffi) 'utils/fullscreen_controller_windows.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: loadData(), // Asegúrate de definir esta función en otro archivo
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const HomePageWithFullScreenToggle();
          }
        },
      ),
    );
  }
}

class HomePageWithFullScreenToggle extends StatefulWidget {
  const HomePageWithFullScreenToggle({Key? key}) : super(key: key);

  @override
  _HomePageWithFullScreenToggleState createState() => _HomePageWithFullScreenToggleState();
}

class _HomePageWithFullScreenToggleState extends State<HomePageWithFullScreenToggle> {
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyEvent);
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.f11) {
      setState(() {
        isFullScreen = !isFullScreen;
        _toggleFullScreen();
      });
    }
  }

  void _toggleFullScreen() {
    toggleFullScreen(isFullScreen);
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
