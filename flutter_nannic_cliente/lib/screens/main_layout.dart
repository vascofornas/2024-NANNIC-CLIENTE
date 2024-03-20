import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key, required this.drawerContent, required this.body}) : super(key: key);

  final Widget drawerContent;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerContent,
      body: body,
    );
  }
}