// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tryflutter/firebase_options.dart';
import 'package:tryflutter/pages/event_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification/firebase_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const InitializationSettings initializationSettings =
      InitializationSettings();

  // Membuat instance FirebaseMessagingService dan memulai inisialisasi
  FirebaseNotification firebaseNotification = FirebaseNotification();
  await firebaseNotification.initializeFirebaseMessaging();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventView(),
    );
  }
}
