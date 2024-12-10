import 'package:flutter/material.dart';

import 'map_screen.dart';

void main() {
  runApp(GMaps());
}

class GMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}
