import 'package:exercise_app/data/database/app_db.dart';
import 'package:exercise_app/exercise_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// var database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Open the notification and show the reference.
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });
// Open the notification and show the reference.
  ExerciseDatabase.instance;

  runApp(const ExerciseApp());
}
