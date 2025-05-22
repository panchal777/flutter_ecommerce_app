import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class BodyWidget extends StatelessWidget {
  final String label;

  const BodyWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    );
  }
}
