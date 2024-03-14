import 'package:flemini/Desktop/screens/main_page.dart';
import 'package:flemini/Mobile/screens/main_page.dart';
import 'package:flutter/material.dart';

class ResponsiveSetting extends StatelessWidget {
  const ResponsiveSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return const DesktopView();
        } else {
          return const MobileView();
        }
      },
    );
  }
}
