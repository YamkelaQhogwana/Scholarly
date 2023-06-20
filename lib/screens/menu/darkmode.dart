import 'package:flutter/material.dart';

class DarkMode extends StatefulWidget {
  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Send Feedback Page"),
      ),
    );
  }
}