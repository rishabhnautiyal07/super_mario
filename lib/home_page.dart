import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario/button.dart';
import 'package:super_mario/jumpingmario.dart';
import 'package:super_mario/mario.dart';
import 'package:super_mario/mashroom.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 static double marioX = 0;
 static double marioY = 1;
 double marioSize = 50;
 double MashroomX = 0.5;
 double MashroomY = 1;
static  double time = 0;
 static double height = 0;
 static double intialHeight = marioY;
 String direction = "right";
 bool midrun = false;
 bool midjump = false;
 var gameFont = GoogleFonts.pressStart2p(
  textStyle: TextStyle(color: Colors.white, fontSize: 20));
  static double blockX = -0.3;
  static double blockY = 0.03;
  double moneyX = blockX;
  double moneyY = blockY;
  int money = 0;

  void checkIFAteMashroom() {
    if ((marioX - MashroomX).abs() < 0.05 && (marioY - MashroomY).abs() < 0.05){
    setState(() {
    //  IF eaten, move the shroomn off the screen
      MashroomX = 2;
      marioSize = 100;
    });
    }

    }

    // SHOW THE MONEY
    void releaseMoney() {
      money++;
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        setState(() {
          moneyY -= 0.1;
        });
        if (moneyY < -1) {
          timer.cancel();
          moneyY = blockY;
        }
      });
    }

    // fall of the plateform
    void fall() {
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        setState(() {
          marioY += 0.05;
        });
      if (marioY > 1) {
        marioY = 1;
        timer.cancel();
        midjump = false;
      }
      });
    }

    // check mario is on thje plateforM
    bool onPlateform(double x, double y) {
      if ((x - blockX).abs() < 0.05 && (y - blockY).abs() < 0.3) {
        midjump = false;
        marioY = blockY - 0.28;
        return true;
      }else {
        return false;

      }
    }
      
      

 void preJump() {
  time = 0;
 intialHeight = marioY;
 }

  void jump() {
 // this first if statement disable the first jump

if (midjump == false){
   midjump = true;
    preJump();
    Timer.periodic(Duration(milliseconds: 50), (timer)  {
    time += 0.05;
    height = -4.9 * time * time + 5 *time;

    if(intialHeight - height > 1){
      midjump = false;
      setState(() {
      marioY = 1;
      });
       timer.cancel();
    } else {
   setState(() {
    marioY = intialHeight - height;
   });
    }
    });
}
  }

  void moveRight() {
    direction = "right";
    checkIFAteMashroom();

   Timer.periodic(Duration(milliseconds: 50), (timer) {
    checkIFAteMashroom();
    if(MyButten().userIsHoldingButton() == true && (marioX + 0.02) < 1){
      setState(() {
        marioX += 0.02;
        midrun = !midrun;
      });
    } else{
      timer.cancel();
    }
   });
  }
    
  void moveLeft() {
    direction = "left";
    checkIFAteMashroom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkIFAteMashroom();
    if(MyButten().userIsHoldingButton() == true && (marioX - 0.02) > -1){
      setState(() {
        marioX -= 0.02;
        midrun = !midrun;
      });
    } else{
      timer.cancel();
    }
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                Container(
              color: Colors.blue,
           child: AnimatedContainer(
            alignment: Alignment(marioX, marioY),
            duration: Duration(milliseconds: 0),
           child: midjump ?
           Jumpingmario(
            direction: direction,
            size: marioSize,

           )
           :
           MyMario(
            direction: direction,
            midrun: midrun,
            size:  marioSize,
           ),    
           ),
           ),
Container(
  alignment: Alignment(MashroomX, MashroomY),
  child: Mashroom(),
),
           Padding(
             padding: const EdgeInsets.only(top: 10.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
              Column(
                children: [
                  Text(
                    "MARIO", 
                    style: gameFont,
                    ), 
                    SizedBox(height: 10),
                    Text("0000", style: gameFont)],
               ),
             Column(
              children: [
                Text(
                  "WORLD", style: gameFont,
                  ),
                  SizedBox(height: 10),
                   Text("1-1", style: gameFont)],
              ),
             Column(
              children: [
                Text(
                  "TIME", style: gameFont,
                  ), 
                  SizedBox(height: 10),
                   Text("9999", style: gameFont)],
              ),
                       ],
             ),
           )
                ],
              ),
              ),
    
          Expanded(
              flex: 1,
              child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButten(
                    child: Icon(Icons.arrow_back, color: Colors.white,
                    ),
              Function: moveLeft,
                  ),
                  MyButten(
                    child: Icon(Icons.arrow_upward, color: Colors.white,
                    ),
                    Function: jump,
                  ),
                  MyButten(
                    child: Icon(Icons.arrow_forward,color: Colors.white,
                    ),
                  Function:  moveRight,
                  ),         
                ],
              ),
              ),
            ),
      
        ],
      ),
    );
  }
}