import 'package:educational_system/Helpers/read_data.dart';
import 'package:educational_system/Home/custom_drawer.dart';
import 'package:flutter/material.dart';
import '../Helpers/util.dart';
import '../Results/results_view.dart';
import '../Results/student_result_view.dart';
import '../Services/course_service.dart';
import 'course_details.dart';

class CoursesPage extends StatefulWidget {
  final String parent;

  const CoursesPage({required this.parent});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  bool isLoading = true;
  Widget childToBeRendered = LinearLoader();
  List<dynamic> courses = [];
  @override
  void initState() {
    super.initState();
    fetchAllSections().then((value) => {
          if (value['response'] == true)
            {
              setState(() {
                courses = value['data'];
                isLoading = false;
              })
            },
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: isLoading == true
          ? LinearLoader()
          : courses.length > 0
              ? ListOfCourses(courses: courses, parent: widget.parent)
              : NoCourseFound,
      drawer: MyDrawer(),
    );
  }
}

class ListOfCourses extends StatelessWidget {
  const ListOfCourses({
    super.key,
    required this.courses,
    required this.parent,
  });

  final List courses;
  final String parent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                onCourseTap(context, course);
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(course['courseCover']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      course['courseName'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Text(
                              course['courseCode'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Text(
                              course['sectionNumber'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${course['startTime']} - ${course['endTime']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      course['courseDescription'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> onCourseTap(context, course) async {
    // Navigate to course details page
    if (parent == "results") {
      var user = await readUserStorageData();
      if (user["userType"] == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseResults(id: course['sectionId']),
          ),
        );
      } else if (user["userType"] == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentResult(id: course['sectionId']),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CourseDetailPage(sectionId: course['sectionId']),
        ),
      );
    }
  }
}

Widget NoCourseFound = Center(
  child: Text("No Course Found!"),
);
