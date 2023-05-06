import 'package:educational_system/Results/result_modal.dart';
import 'package:educational_system/Results/result_viewModal.dart';
import 'package:flutter/material.dart';

import '../Services/section_service.dart';

class CourseResults extends StatefulWidget {
  final String id;

  CourseResults({required this.id});

  @override
  _CourseResultsState createState() => _CourseResultsState();
}

class _CourseResultsState extends State<CourseResults> {
  var sectionDetail = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    fetchSectionDetails(widget.id).then((value) => {
          print(value),
          if (value['response'] == true)
            {
              setState(() {
                sectionDetail = value['data'];
              })
            },
        });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(sectionDetail.isNotEmpty ? sectionDetail["courseName"] : ""),
        titleSpacing: 16.0,
      ),
      body: sectionDetail.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: theme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Positioned.fill(
                          bottom: MediaQuery.of(context).size.height * .2,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(sectionDetail['courseCover']),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sectionDetail["courseName"],
                                  style: TextStyle(
                                    color: theme.onSecondaryContainer,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${sectionDetail['courseCode']} (${sectionDetail["sectionNumber"]})',
                                  style: TextStyle(
                                    color: theme.onSecondaryContainer,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "All Students",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  sectionDetail['students'].isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("No students found"),
                        )
                      : ListView.builder(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: sectionDetail['students'].length,
                          itemBuilder: (context, index) {
                            dynamic student = sectionDetail['students'][index];
                            print(student);
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              child: Card(
                                child: Container(
                                  //margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                      title: Text(
                                          '${student['name']} - (${student['studentId']})'),
                                      subtitle: Row(
                                        children: [
                                          Text("Grade - "),
                                          Text(student['result'] != null
                                              ? student['result']['grade']
                                              : "No grade found")
                                        ],
                                      ),
                                      trailing: student['result'] != null
                                          ? ResultViewModal(
                                              result: student['result'],
                                            )
                                          : ResultModal(
                                              courseCode:
                                                  sectionDetail['courseCode'],
                                              courseName:
                                                  sectionDetail["courseName"],
                                              belongsTo: student['id'],
                                              onSubmitSuccess: fetchData,
                                            )),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
