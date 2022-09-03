import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar {
  //headerComponent
  static PreferredSizeWidget adaptiveAppBar(
      String title, List<Widget> actions) {
    return Platform.isIOS
        ? PreferredSize(
            preferredSize: const Size.fromHeight(56), //default height value
            child: CupertinoNavigationBar(
              middle: Text(title), //title
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ), //actions
            ),
          )
        : PreferredSize(
            preferredSize: const Size.fromHeight(56), //default height value
            child: AppBar(
              title: Text(title),
              actions: actions,
            ),
          );
  }
}
