import 'package:bloc_practise/constant/routes/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final app_router router = app_router();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateroutes,
    );
  }
}


