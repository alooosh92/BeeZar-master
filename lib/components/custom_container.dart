import 'package:beezar/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomedContainer extends StatelessWidget {
  double x = 0, y = 0;
  dynamic child;
  double height = 0;

  CustomedContainer(this.x, this.y, this.height, this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              Colors.white,
              mainColor,

            ]

        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(x), topRight: Radius.circular(y)),
      ),
      child: child,
    );
  }
}