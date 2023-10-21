import 'package:flutter/material.dart';

import '../constants.dart';


class SmallNav extends StatelessWidget {
  String name="";
  var ontap;
  SmallNav({
    required this.name,
    required this.ontap,
  });
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.05,
            width: MediaQuery.of(context).size.width *
                0.2,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(name,
                style: TextStyle(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width *
                0.03,
          ),
        ],
      ),
    );
  }
}
