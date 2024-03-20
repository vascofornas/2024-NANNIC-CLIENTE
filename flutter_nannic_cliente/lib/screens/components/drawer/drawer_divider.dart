import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';

Padding buildPaddingDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
    child: Divider(
      color: grey,
      thickness: 0.2,
    ),
  );
}