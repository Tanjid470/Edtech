import 'package:edtech/constants/app_colors.dart';
import 'package:edtech/constants/app_textStyle.dart';
import 'package:edtech/controller/dashboard_Controller.dart';
import 'package:edtech/screen/CoursePlayer/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursePlayerPage extends StatefulWidget {
  //final String videoId = 'g_sfv9IVCu4';
  @override
  _CoursePlayerPageState createState() => _CoursePlayerPageState();
}

class _CoursePlayerPageState extends State<CoursePlayerPage> {
  int currentModuleIndex = 0;
  List<String> bookmarks = [];
  DashBoardController dashBoardController = Get.put(DashBoardController());

  late YoutubePlayerController _controller;

  List<Subtitle> subtitle = [
    Subtitle(start: 2, end: 10, text: "Animated Contatiner Widget in Flutter"),
    // subtitle start at 2 second and end at 10 second
    Subtitle(start: 10, end: 20, text: "You can add your custom subtitle"),
    Subtitle(start: 20, end: 100, text: ""),
    // add mor subtitle as your requirement
  ];
  String subtitleText = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = YoutubePlayerController(
          initialVideoId: dashBoardController.videos[currentModuleIndex],
          flags: const YoutubePlayerFlags(autoPlay: true, mute: false))
        ..addListener(_onPlayerStateChange);
    });
  }

  void _onPlayerStateChange() {
    if (_controller.value.playerState == PlayerState.playing) {
      final currentTime = _controller.value.position.inSeconds;
      final currentSubtitle = subtitle.firstWhere((subtitle) =>
          currentTime >= subtitle.start && currentTime <= subtitle.end);

      // Update the UI with the current subtitle
      setState(() {
        subtitleText = currentSubtitle.text;
      });
    }
  }

  // Mock function to simulate video playback time update
  void _updateTime(String time) {
    setState(() {
      //  currentTime = time;
    });
  }

  // Mock function to simulate bookmarking functionality
  void _bookmarkCurrentTime() {
    setState(() {
      dashBoardController.currentTime = DateTime.now();
      bookmarks.add(dashBoardController.currentTime.day.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Using BoxDecoration to set a gradient background for the AppBar
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.bgGradient, // Set your gradient here
          ),
        ),
        title: Text(
          dashBoardController
              .enrolledCourses[dashBoardController.selectedIndex].title,
        ),
        // Other AppBar properties...
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 40, 64, 143),
          Color.fromARGB(255, 74, 39, 155)
        ])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              YoutubePlayer(controller: _controller),
              lowerLayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Expanded lowerLayer(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dashBoardController.courseModules[currentModuleIndex],
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          Colors.teal.shade600 // Set the background color here
                      ),
                  onPressed: currentModuleIndex > 0
                      ? () {
                          setState(() {
                            currentModuleIndex--;
                          });
                        }
                      : null,
                  child: Text(
                    'Previous',
                    style: customSize(10, Colors.white),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          Colors.teal.shade600 // Set the background color here
                      ),
                  onPressed: currentModuleIndex <
                          dashBoardController.courseModules.length - 1
                      ? () {
                          setState(() {
                            currentModuleIndex++;
                          });
                        }
                      : null,
                  child: Text('Next', style: customSize(12, Colors.white)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _bookmarkCurrentTime,
                style: ElevatedButton.styleFrom(
                    primary:
                        Colors.teal.shade600 // Set the background color here
                    ),
                child: const Text('Add Bookmark'),
              ),
              TextButton(
                onPressed: () {
                  // Show bookmarks or manage bookmarks
                  // For simplicity, display a dialog with bookmarks
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Bookmarks'),
                        content: SingleChildScrollView(
                          child: bookmarks.isEmpty
                              ? const Center(child: Text('empty'))
                              : ListBody(
                                  children: bookmarks.map((time) {
                                    return ListTile(
                                      title: Text('Bookmark at $time'),
                                    );
                                  }).toList(),
                                ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'View Bookmarks',
                  style: customSize(15, Colors.teal.shade300),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        if (currentModuleIndex == dashBoardController.courseModules.length - 1)
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Certificate'),
                      content: Container(
                        height: 180,
                        //   width: ,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://previews.123rf.com/images/fdsstudio/fdsstudio1906/fdsstudio190600039/124617234-beautiful-certificate-template-vector-design-for-award-diploma-blue-certificate-of-appreciation.jpg'),
                                fit: BoxFit.fill)),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Download'),
                        ),
                      ],
                    );
                  },
                );

                // Navigate to the dashboard after completing the course
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text('Claim Your Certificate'),
            ),
          ),
      ],
    ));
  }
}
