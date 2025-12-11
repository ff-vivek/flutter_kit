import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterkit/theme.dart';
import 'package:flutterkit/nav.dart';

Future<void> initializePreviewApp() async {
  // No initialization steps needed
}

Widget wrapPreview(Widget Function() buildPreviewWidget) {
  return MaterialApp(
    title: 'FlutterKit',
    debugShowCheckedModeBanner: false,

    // Theme configuration
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,

    home: buildPreviewWidget(),
  );
}
