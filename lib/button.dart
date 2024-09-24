import 'package:flutter/material.dart';

class MyButten
 extends StatelessWidget {
  final child;
  final Function;
  static bool holdingButton = false;

  MyButten({this.child, this.Function});
  
  bool userIsHoldingButton() {
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details){
    holdingButton = true;
    Function();
      },
      onTapUp: (details){
        holdingButton = false;
      },
      child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(10),
          color: Colors.brown[300], 
           child: child,
              ),
        ),
    );
  }
}