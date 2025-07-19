// fullscreen_controller_windows.dart
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

void toggleFullScreen(bool isFullScreen) {
  final hwnd = GetForegroundWindow();

  if (isFullScreen) {
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
    final style = GetWindowLongPtr(hwnd, GWL_STYLE);
    SetWindowLongPtr(hwnd, GWL_STYLE, style | WS_OVERLAPPEDWINDOW);

    SetWindowPos(
      hwnd,
      NULL,
      100,
      100,
      800,
      600,
      SWP_FRAMECHANGED | SWP_NOOWNERZORDER | SWP_NOZORDER,
    );
  }
}
