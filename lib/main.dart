import 'package:booking_app/screens/home.screen.dart';
import 'package:booking_app/screens/landing.screen.dart';

import 'package:booking_app/providers/auth.provider.dart';
import 'package:booking_app/providers/booking.provider.dart';
import 'package:booking_app/providers/events.provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: EventsProvider()),
        ChangeNotifierProvider.value(value: BookProvider())
      ],
      child: Consumer(builder: (BuildContext context, AuthProvider auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'online_booking',
          home: auth.isAuth ? const HomeScreen() : const LandingScreen(),
        );
      }
      ),
    );
  }
} 
