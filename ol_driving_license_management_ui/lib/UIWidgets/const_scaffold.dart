import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_drawer.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
    this.hasLeading = false,
  });

  final String title;
  final Widget body;

  final Widget? bottomNavigationBar;

  final bool? hasLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading:
            hasLeading!
                ? IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: Icon(Icons.arrow_back),
                )
                : null,
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      drawer: const BaseDrawer(),
      body: body,

      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
