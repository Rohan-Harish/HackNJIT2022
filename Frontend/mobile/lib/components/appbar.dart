import 'package:flutter/material.dart';

class appBarDefault extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Clean Cart"),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
