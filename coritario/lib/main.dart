import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:win32/win32.dart';
import 'package:coritario/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading screen while data is being loaded
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            // Once data is loaded, navigate to HomePage
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
    // Listen for key events
    RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyEvent);
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.f11) {
        setState(() {
          isFullScreen = !isFullScreen;
          _toggleFullScreen();
        });
      }
    }
  }

  void _toggleFullScreen() {
    final hwnd = GetForegroundWindow();
    if (isFullScreen) {
      // Set to full screen
      final style = GetWindowLongPtr(hwnd, GWL_STYLE);
      final exStyle = GetWindowLongPtr(hwnd, GWL_EXSTYLE);

      SetWindowLongPtr(hwnd, GWL_STYLE, style & ~WS_OVERLAPPEDWINDOW);
      SetWindowLongPtr(hwnd, GWL_EXSTYLE, exStyle | WS_EX_TOPMOST);

      final monitor = MonitorFromWindow(hwnd, MONITOR_DEFAULTTOPRIMARY);
      final monitorInfo = calloc<MONITORINFO>()..ref.cbSize = sizeOf<MONITORINFO>();
      GetMonitorInfo(monitor, monitorInfo);

      SetWindowPos(
        hwnd,
        NULL,
        monitorInfo.ref.rcMonitor.left,
        monitorInfo.ref.rcMonitor.top,
        monitorInfo.ref.rcMonitor.right - monitorInfo.ref.rcMonitor.left,
        monitorInfo.ref.rcMonitor.bottom - monitorInfo.ref.rcMonitor.top,
        SWP_FRAMECHANGED | SWP_NOOWNERZORDER | SWP_NOZORDER,
      );

      free(monitorInfo);
    } else {
      // Restore from full screen
      final style = GetWindowLongPtr(hwnd, GWL_STYLE);
      SetWindowLongPtr(hwnd, GWL_STYLE, style | WS_OVERLAPPEDWINDOW);

      SetWindowPos(
        hwnd,
        NULL,
        100, // X position
        100, // Y position
        800, // Width
        600, // Height
        SWP_FRAMECHANGED | SWP_NOOWNERZORDER | SWP_NOZORDER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
