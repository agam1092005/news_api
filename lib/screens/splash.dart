// ignore_for_file: file_names, invalid_use_of_visible_for_testing_member, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashStartScreen extends StatefulWidget {
  const SplashStartScreen({super.key});

  @override
  State<SplashStartScreen> createState() => _SplashStartScreenState();
}

class _SplashStartScreenState extends State<SplashStartScreen> {
  var logged;
  getData() async {
    (Platform.isAndroid) ? await FlutterDisplayMode.setHighRefreshRate() : null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logged = prefs.getBool('loggedin');
    });
  }

  @override
  void initState() {
    getData();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, logic());
      HapticFeedback.selectionClick();
    });
    super.initState();
  }

  logic() {
    if (logged == null) {
      return '/login';
    } else {
      if (logged == true) {
        return '/news';
      } else {
        return '/login';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                "assets/logo.png",
              ),
              width: 250,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'MyNews',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30,
              color: Color(0xFF0C54BE),
            ),
          ),
        ],
      ),
    );
  }
}
