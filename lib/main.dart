import 'package:flutter/material.dart';
import 'screens/printer_selection_screen.dart';

void main() {
  runApp(const MenuLiveApp());
}

class MenuLiveApp extends StatelessWidget {
  const MenuLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Live',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.dark,
      ),
      home: const PrinterSelectionScreen(),
    );
  }
}
