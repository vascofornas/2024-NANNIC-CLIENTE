import 'package:flutter/material.dart';

Future<bool> onWillPop(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
          child: new Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
          child: new Text('Yes'),
        ),
      ],
    ),
  )) ??
      false;
}