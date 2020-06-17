//Packages
import 'package:flutter/material.dart';
import 'package:moallem/home_screen.dart';
import 'package:moallem/videoplayer_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Disabling the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Moallem',

        //Setting the default screen
        home: HomeScreen(),

        //Defining the routes of the different screens
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          VideoPlayerScreen.routeName: (ctx) => VideoPlayerScreen(),

        }
    );
  }
}
