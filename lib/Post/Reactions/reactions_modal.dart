import 'package:flutter/material.dart';

class AllReactionsModal extends StatelessWidget {
  final List<dynamic> reactions;

  const AllReactionsModal({
    Key? key,
    required this.reactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Reactions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ],
            ),
            Expanded(
              child: DefaultTabController(
                length: reactions.length,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      indicatorColor: Colors.blue,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        for (var reaction in reactions)
                          Row(
                            children: [
                              Icon(
                                reaction['view']['iconFilled'],
                                color: reaction['view']['color'],
                                size: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                reaction['view']['name'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          for (var reaction in reactions)
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var data in reaction['data'])
                                    Row(
                                      children: [
                                        Text(
                                          data['createdBy'],
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
