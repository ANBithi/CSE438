import 'package:flutter/material.dart';
import '../Services/result_service.dart';

class ResultModal extends StatefulWidget {
  final String courseCode;
  final String courseName;
  final String belongsTo;
  final dynamic onSubmitSuccess;
  const ResultModal(
      {Key? key,
      required this.courseCode,
      required this.courseName,
      required this.belongsTo,
      required this.onSubmitSuccess})
      : super(key: key);

  @override
  _ResultModalState createState() => _ResultModalState();
}

class _ResultModalState extends State<ResultModal> {
  final TextEditingController _quizMarkController = TextEditingController();
  final TextEditingController _midMarkController = TextEditingController();
  final TextEditingController _finalMarkController = TextEditingController();
  final TextEditingController _projectMarkController = TextEditingController();
  final TextEditingController _assignmentMarkController =
      TextEditingController();
  final TextEditingController _attendanceMarkController =
      TextEditingController();

  Future<void> _onSubmitClick() async {
    var obj = {
      "quizMark": double.parse(_quizMarkController.text),
      "midMark": double.parse(_midMarkController.text),
      "projectMark": double.parse(_projectMarkController.text),
      "AssignmentMark": double.parse(_assignmentMarkController.text),
      "attendanceMark": double.parse(_attendanceMarkController.text),
      "finalMark": double.parse(_finalMarkController.text),
    };
    var resultObj = {
      ...obj,
      "courseCode": widget.courseCode,
      "courseName": widget.courseName,
      "belongsTo": widget.belongsTo
    };
    await ResultService.addResult(resultObj);
    widget.onSubmitSuccess();
  }

  @override
  void dispose() {
    _quizMarkController.dispose();
    _midMarkController.dispose();
    _finalMarkController.dispose();
    _projectMarkController.dispose();
    _assignmentMarkController.dispose();
    _attendanceMarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _quizMarkController,
                      decoration: InputDecoration(labelText: 'Quiz Mark'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _midMarkController,
                      decoration: InputDecoration(labelText: 'Mid Mark'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _finalMarkController,
                      decoration: InputDecoration(labelText: 'Final Mark'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _projectMarkController,
                      decoration: InputDecoration(labelText: 'Project Mark'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _assignmentMarkController,
                      decoration: InputDecoration(labelText: 'Assignment Mark'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _attendanceMarkController,
                      decoration: InputDecoration(labelText: 'Attendance Mark'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _onSubmitClick();
                            Navigator.pop(context);
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(Icons.sentiment_dissatisfied),
        label: Text("Add Result"));
  }
}
