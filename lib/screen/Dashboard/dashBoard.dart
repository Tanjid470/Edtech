import 'package:edtech/constants/app_colors.dart';
import 'package:edtech/constants/app_textStyle.dart';
import 'package:edtech/controller/dashboard_Controller.dart';
import 'package:edtech/screen/CoursePlayer/course_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DashBoardController dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.bgcolor ,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Dashboard'),
      ),
      body: Container(
        color: AppColors.bgcolor,
        child: ListView.builder(
          itemCount: dashBoardController.enrolledCourses.length,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 40, 64, 143),
                    Color.fromARGB(255, 74, 39, 155)
                  ]),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        blurStyle: BlurStyle.outer,
                        color: Colors.white)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dashBoardController.enrolledCourses[index].title,
                    style: customSize(20, Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        dashBoardController.selectedIndex=index;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CoursePlayerPage()),
                        );
                      },
                      child: Text(
                        "Continue Course",
                        style: customSize(16, Colors.blue),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
