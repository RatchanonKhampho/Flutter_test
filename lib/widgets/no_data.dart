import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  final String title;
  final String details;
  // ignore: use_key_in_widget_constructors
  const NoDataScreen({required this.title, required this.details});
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.orangeAccent,
              ),
            ),
            Text(
              details,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
