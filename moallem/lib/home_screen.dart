import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moallem/videoplayer_screen.dart';
import 'package:video_player/video_player.dart';


class HomeScreen extends StatefulWidget {

  //Setting a route name for the screen for easy access
  static const routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //Initializing a key for the scaffold widget
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Declaring the video controller
  VideoPlayerController _controller;

  //Array of maps to define the name and image of each subject
  final subject = [
    {'name': 'Physics', 'image': 'assets/Physics.png'},
    {'name': 'Biology', 'image': 'assets/Biology.png'},
    {'name': 'History', 'image': 'assets/History.png'},
    {'name': 'Algebra', 'image': 'assets/Algebra.png'},
  ];



  @override
  void initState() {
    super.initState();
    //Initializing the video controller
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }


  //Disposing the video controller to avoid memory leakage
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Subjects',
                  style: TextStyle(
                      fontSize: deviceSize.width * 0.08,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: subject.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                deviceSize.width * 0.04, 15, 0, 5),
                            child: Text(
                              subject[index]['name'],
                              style: TextStyle(
                                  fontSize: deviceSize.width * 0.045,
                                  color: Colors.green),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          )
                        ],
                      )),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      deviceSize.width * 0.07, deviceSize.height * 0.07, 0, 0),
                  child: Text(
                    'Moallem',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: deviceSize.width * 0.08,
                        color: Colors.green),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(deviceSize.width * 0.07,
                      deviceSize.height * 0.07, deviceSize.width * 0.08, 0),
                  child: FlatButton(
                    child: Image.asset(
                      'assets/menuItem.png',
                      width: deviceSize.width * 0.07,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(deviceSize.width * 0.07,
                  deviceSize.height * 0.04, 0, deviceSize.height * 0.03),
              child: Text(
                'Subjects',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.06,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: subject.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                deviceSize.width * 0.04, 15, 0, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                child: Image.asset(
                                  subject[index]['image'],
                                  width: deviceSize.width * 0.2,
                                ),
                                padding: EdgeInsets.all(30),
                              ),
                              elevation: 20,
                            ),
                            width: deviceSize.width * 0.25,
                            height: deviceSize.width * 0.25,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                deviceSize.width * 0.04, 15, 0, 0),
                            child: Text(
                              subject[index]['name'],
                              style: TextStyle(
                                  fontSize: deviceSize.width * 0.045,
                                  color: Colors.green),
                            ),
                          ),
                        ],
                      )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.07, deviceSize.height * 0.005 , 0, 0),
              child: Text(
                'Welcome Back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.06,
                    color: Colors.green),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.07, 0, 0, deviceSize.height * 0.02),
              child: Text(
                'Continue learning?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.06,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: subject.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(VideoPlayerScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: deviceSize.width * 0.05),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        _controller.value.initialized
                            ? Container(
                                width: deviceSize.height * 0.35,
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ))
                            : Container(),
                        Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
