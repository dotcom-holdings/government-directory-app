import 'package:flutter/material.dart';
import 'package:government_directory/login.dart';
import 'package:government_directory/signup.dart';
import 'package:government_directory/home.dart';
import 'package:government_directory/search_page.dart';
//importing login page here

void main() => runApp(
  new MaterialApp(
      title: "Flutter",
      home: new LoginPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/search': (context) => search_page(),
      },
    ));