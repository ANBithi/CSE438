import 'package:flutter/material.dart';

class ResultViewModal extends StatelessWidget {
  final dynamic result;
  const ResultViewModal({required this.result});

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
                    ResultViewItem(label: "Grade - ", value: result['grade']),
                    ResultViewItem(
                        label: "GPA - ",
                        value: result['gpa'].toStringAsFixed(2)),
                    ResultViewItem(
                        label: "Quiz Mark - ",
                        value: result['quizMark'].toStringAsFixed(2)),
                    ResultViewItem(
                        label: "Mid Mark - ",
                        value: result['midMark'].toStringAsFixed(2)),
                    ResultViewItem(
                        label: "Final Mark - ",
                        value: result['finalMark'].toStringAsFixed(2)),
                    ResultViewItem(
                        label: "Project Mark - ",
                        value: result['projectMark'].toStringAsFixed(2)),
                    ResultViewItem(
                        label: "Assignment Mark - ",
                        value: result['assignmentMark'].toStringAsFixed(2)),
                    ResultViewItem(
                        label: "Attendance Mark - ",
                        value: result['attendanceMark'].toStringAsFixed(2)),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(Icons.view_column_rounded),
        label: Text("View Result"));
  }
}

class ResultViewItem extends StatelessWidget {
  const ResultViewItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(label),
          Text(value),
        ],
      ),
    ));
  }
}
