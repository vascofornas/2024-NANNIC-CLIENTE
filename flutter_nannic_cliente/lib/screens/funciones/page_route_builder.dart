import 'package:flutter/material.dart';

PageRouteBuilder<dynamic> buildPageRouteBuilder(StatefulWidget nextScreen) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}