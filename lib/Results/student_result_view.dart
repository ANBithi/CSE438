import 'package:flutter/material.dart';

import '../Services/result_service.dart';

class StudentResult extends StatefulWidget {
  final String id;

  StudentResult({required this.id});

  @override
  _StudentResultState createState() => _StudentResultState();
}

class _StudentResultState extends State<StudentResult> {
  var results = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    ResultService.getResults().then((value) => {
          if (value['response'] == true)
            {
              setState(() {
                results = value['data'];
              })
            },
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        titleSpacing: 16.0,
      ),
      body: results.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  results.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("No results found"),
                        )
                      : ListView.builder(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            dynamic result = results[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              child: Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(children: [
                                    Text(
                                      '${result['courseCode']} ${result['courseName']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Grade",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "GPA",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${result['grade']}',
                                        ),
                                        Text(
                                          '${result['gpa'].toStringAsFixed(2)}',
                                        ),
                                      ],
                                    ),
                                  ]),
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
