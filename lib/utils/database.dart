import 'package:calendar/utils/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid = ""});
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection("events");

  Future updateUserData(String title, String description, DateTime from,
      DateTime to, String backgroundColor, bool isAllDay) async {
    return await eventCollection.doc(uid).set({
      'title': title,
      'description': description,
      'from': from,
      'to': to,
      'bgColor': backgroundColor,
      'isAllDay': isAllDay
    });
  }

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => Event(
            title: e.get('title'),
            isAllDay: e.get('isAllDay'),
            from: e.get('from'),
            to: e.get('to'),
            backgroundColor: Color(e.get('bgColor'))))
        .toList();
  }

  Stream<QuerySnapshot> get events {
    return eventCollection.snapshots();
  }
}
