import 'package:flutter/material.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard({super.key});

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Workorder Approve'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                  // leading: Icon(Icons.album),
                  // title: Text("Welcome to My about Me"),
                  // subtitle: Text("Sirintorn Pengsiri"),
                  ),
              Container(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'This is a card with a button',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 16),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your onPressed code here!
                              print('Button pressed!');
                            },
                            child: Text('Approve'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your onPressed code here!
                              print('Button pressed!');
                            },
                            child: Text('View'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your onPressed code here!
                              print('Button pressed!');
                            },
                            child: Text('Cancel'),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
