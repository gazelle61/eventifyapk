  // // ignore_for_file: prefer_const_constructors

  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:flutter/material.dart';
  // import 'package:tryflutter/services/database_service.dart';

  // class EventView extends StatefulWidget {
  //   const EventView({super.key});

  //   @override
  //   State<EventView> createState() => _HomepageState();
  // }

  // class _HomepageState extends State<EventView> {
  //   // firestore
  //   final DatabaseService databaseService = DatabaseService();

  //   // text controller
  //   final TextEditingController textEditingController = TextEditingController();

  //   // open a dialog vox to add an event
  //   void openNoteBox({String? docID}) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         content: TextField(
  //           controller: textEditingController,
  //         ),
  //         actions: [
  //           // button to save
  //           ElevatedButton(
  //             onPressed: () {
  //               // add a new event
  //               if (docID == null) {
  //                 databaseService.addEvent(textEditingController.text);
  //               }

  //               // update an existing event
  //               else {
  //                 databaseService.updateEvent(docID, textEditingController.text);
  //               }

  //               // clear the text controller
  //               textEditingController.clear();

  //               // close the box
  //               Navigator.pop(context);
  //             },
  //             child: Text("Add"),
  //           )
  //         ],
  //       ),
  //     );
  //   }

  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text("My Events")),
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () => openNoteBox(),
  //         child: const Icon(Icons.add),
  //       ),
  //       body: StreamBuilder<QuerySnapshot>(
  //         stream: databaseService.getEventsStream(),
  //         builder: (context, snapshot) {
  //           // if we have data, get all the docs
  //           if (snapshot.hasData) {
  //             List eventsList = snapshot.data!.docs;

  //             // display as a list
  //             return ListView.builder(
  //               itemCount: eventsList.length,
  //               itemBuilder: (context, index) {
  //                 // get each individual doc
  //                 DocumentSnapshot document = eventsList[index];
  //                 String docID = document.id;

  //                 // get event from each doc
  //                 Map<String, dynamic> data =
  //                     document.data() as Map<String, dynamic>;
  //                 String eventText = data['events'] ?? 'No event title';

  //                 // display as a list tile
  //                 return ListTile(
  //                   title: Text(eventText ?? 'No event title'),
  //                   trailing: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       // update button
  //                       IconButton(
  //                         onPressed: () => openNoteBox(docID: docID),
  //                         icon: const Icon(Icons.settings),
  //                       ),

  //                       // delete button
  //                       IconButton(
  //                         onPressed: () => databaseService.deleteEvent(docID),
  //                         icon: const Icon(Icons.delete),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             );
  //           } else {
  //             return const Text("No events...");
  //           }
  //         },
  //       ),
  //     );
  //   }
  // }

  // ignore_for_file: prefer_const_constructors

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:tryflutter/services/database_service.dart';

  class EventView extends StatefulWidget {
    const EventView({super.key});

    @override
    State<EventView> createState() => _HomepageState();
  }

  class _HomepageState extends State<EventView> {
    // firestore
    final DatabaseService databaseService = DatabaseService();

    // text controller
    final TextEditingController textEditingController = TextEditingController();

    // open a dialog box to add an event
    void openNoteBox({String? docID}) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textEditingController,
          ),
          actions: [
            // button to save
            ElevatedButton(
              onPressed: () {
                // add a new event
                if (docID == null) {
                  databaseService.addEvent(textEditingController.text);
                }

                // update an existing event
                else {
                  databaseService.updateEvent(docID, textEditingController.text);
                }

                // clear the text controller
                textEditingController.clear();

                // close the box
                Navigator.pop(context);
              },
              child: Text("Add"),
            )
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("My Events")),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openNoteBox(),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: databaseService.getEventsStream(),
          builder: (context, snapshot) {
            // if we have data, get all the docs
            if (snapshot.hasData) {
              List eventsList = snapshot.data!.docs;

              // display as a list
              return ListView.builder(
                itemCount: eventsList.length,
                itemBuilder: (context, index) {
                  // get each individual doc
                  DocumentSnapshot document = eventsList[index];
                  String docID = document.id;

                  // get event from each doc
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                  // Handle both 'event' (for new events) and 'events' (for updated events)
                  String eventText = data['event'] ?? data['events'] ?? 'No event title'; // Fix here

                  // display as a list tile
                  return ListTile(
                    title: Text(eventText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // update button
                        IconButton(
                          onPressed: () => openNoteBox(docID: docID),
                          icon: const Icon(Icons.settings),
                        ),

                        // delete button
                        IconButton(
                          onPressed: () => databaseService.deleteEvent(docID),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Text("No events...");
            }
          },
        ),
      );
    }
  }
