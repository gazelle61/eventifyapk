import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // get collection of events
  final CollectionReference events =
      FirebaseFirestore.instance.collection('event');

  // CREATE : add a new event
  Future<void> addEvent(String event) {
    return events.add({
      'event': event,
      'timestamp': Timestamp.now(),
    });
  }

  // READ : get events from database
  Stream<QuerySnapshot> getEventsStream() {
    final eventsStream =
        events.orderBy('timestamp', descending: true).snapshots();

    return eventsStream;
  }

  // UPDATE : update events given a doc id
  Future<void> updateEvent(String docID, String newEvent) {
    return events.doc(docID).update({
      'events': newEvent,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE : delete events given a doc id
  Future<void> deleteEvent(String docID) {
    return events.doc(docID).delete();
  }
}

