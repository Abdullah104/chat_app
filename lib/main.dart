import 'package:chat_app/routes/authentication_route.dart';
import 'package:chat_app/routes/chat_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((message) {});

  FirebaseMessaging.instance.subscribeToTopic('chat');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class MyApp extends StatelessWidget {
  final _theme = ThemeData(
    primarySwatch: Colors.pink,
    backgroundColor: Colors.pink,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _theme.copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Colors.deepPurple,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.pink,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: _theme.primaryColor,
        ),
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AuthenticationRoute.routeName
          : ChatRoute.routeName,
      routes: {
        ChatRoute.routeName: (_) => const ChatRoute(),
        AuthenticationRoute.routeName: (_) => const AuthenticationRoute(),
      },
    );
  }
}
