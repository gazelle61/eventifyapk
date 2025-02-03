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
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                databaseService.addEvent(textEditingController.text);
              } else {
                databaseService.updateEvent(docID, textEditingController.text);
              }
              textEditingController.clear();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Header Image
          Container(
            width: double.infinity,
            height: 237,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/header.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Search Bar Container di atas header image
          Positioned(
            top: 210,
            left: 55,
            right: 55,
            child: Container(
              width: 50, // Adjusted width
              height: 50, // Adjusted height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search events',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(
                      'assets/images/sort.png',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Teks "Home" di atas header image
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // Ikon Sidebar di kiri atas
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 35),
              child: Container(
                width: 22,
                height: 19,
                child: Image.asset(
                  'assets/images/sidebar.png',
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Ikon Notifikasi di kanan atas
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 35),
              child: Container(
                width: 18.33,
                height: 20,
                child: Image.asset(
                  'assets/images/notificationblack.png',
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Popular Events
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 280),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Opacity(
                  opacity: 0.40,
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Color(0xFFFFD166),
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Isi Body
          Positioned.fill(  
            top: 305, 
            child: StreamBuilder<QuerySnapshot>(
              stream: databaseService.getEventsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List eventsList = snapshot.data!.docs;

                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10), 
                    itemCount: eventsList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = eventsList[index];
                      String docID = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String eventText = data['events'] ?? "events";

                      return ListTile(
                        title: Text(
                          eventText,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // update button
                            IconButton(
                              onPressed: () => openNoteBox(docID: docID),
                              icon: const Icon(Icons.settings,
                                  color: Colors.white),
                            ),

                            // delete button
                            IconButton(
                              onPressed: () =>
                                  databaseService.deleteEvent(docID),
                              icon: const Icon(Icons.delete,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No events...",
                        style: TextStyle(color: Colors.white)),
                  );
                }
              },
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(),
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 255, 186, 57),
      ),
    );
  }
}
