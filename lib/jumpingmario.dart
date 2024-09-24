import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_mario/mario.dart';

class Jumpingmario extends StatelessWidget {

final direction;
final size;

Jumpingmario({this.direction, this.size});


  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
      width: size,
      height: size,
      child: Image.asset("lib/images/jumping.png"),
    );
    } else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
        width: size,
        height: size,
        child: Image.asset("lib/images/jumping.png"),
            ),
      );
    }
  }
}