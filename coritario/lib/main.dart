

import 'package:coritario/pages/home.dart';
import 'package:flutter/material.dart';






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
            return const HomePage();
          }
        },
      ),
    );
  }
}


/*
return const MaterialApp(
      home: HomePage()
    );
*/