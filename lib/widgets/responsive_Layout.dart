import 'dart:developer';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget DesktopBody;

  const ResponsiveLayout(
      {Key? key, required this.mobileBody, required this.DesktopBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return mobileBody;
        } else {
          return DesktopBody;
        }
      },
    );
  }
}
