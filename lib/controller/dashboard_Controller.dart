import 'package:get/get.dart';

class DashBoardController extends GetxController {
  List<Course> enrolledCourses = [
    Course(title: 'Flutter', courseId: 'course_id_1'),
    Course(title: 'Algorithms', courseId: 'course_id_2'),
    Course(title: 'Image Processing', courseId: 'course_id_3'),
    Course(title: 'Operating System', courseId: 'course_id_4'),
    Course(title: 'Java', courseId: 'course_id_5'),
    Course(title: 'Data Stracture', courseId: 'course_id_6'),
    Course(title: 'Digital Logic Design', courseId: 'course_id_7'),
    Course(title: 'MIS 4001', courseId: 'course_id_8'),
    // Add more courses as needed
  ];

  int selectedIndex = 0;

  var currentTime = DateTime.now();
  List<String> courseModules = [
    'Module 1: Introduction',
    'Module 2: Advanced Topics',
    'Module 3: Final Project',
    // Add more modules as needed
  ];
  List<String> videos = [
    'g_sfv9IVCu4',
    '0sacQ4oo-P0',
    'oi6zk7cVHUw',
  ];
}

class Course {
  final String title;
  final String courseId;
  Course({required this.title, required this.courseId});
}
