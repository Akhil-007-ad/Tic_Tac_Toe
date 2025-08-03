import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  bool Oturn=true;
  List<String> displayXO=["","","","","","","","",""];

  String resultDeclaration="";
  int oScore=0;
  int xScore=0;
  int filledBoxes=0;
  bool winnerFound=false;
  int attempts=0;

  Timer? timer;
  static const maxSeconds=30;
  int seconds=maxSeconds;

  List<int>matchedIndexes=[];

  void _startTimer(){
    timer=Timer.periodic(Duration(seconds: 1), (_){
    setState(() {
      if(seconds>0){
        seconds--;
      }else {
        setState(() {
          resultDeclaration="Timed Out!!!";
        });
        _stopTimer();
      }
    });
    });
  }

  void _stopTimer(){
    _resetTimer();
    timer?.cancel();
  }

  void _resetTimer() => seconds=maxSeconds;


  static var customFont=GoogleFonts.coiny(
    textStyle:TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w800
    )

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB2BEB5),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
           Expanded(flex:1,
               child: Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Container(
                             height: 38,
                             width: 150,
                             decoration: BoxDecoration(
                               color: Colors.black,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.white,
                                   spreadRadius: 2,
                                   blurRadius: 2,
                                 )
                               ]
                             ),
                             child: Center(child: Text("Player O" ,style:customFont))),
                         Text(oScore.toString(),style: TextStyle(fontFamily: customFont.fontFamily,fontSize: 25,))
                       ],),
                     SizedBox(width: 20,),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Container(
                             height: 38,
                             width: 150,
                             decoration: BoxDecoration(
                                 color: Colors.black,
                                 borderRadius: BorderRadius.circular(12),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.white,
                                     spreadRadius: 2,
                                     blurRadius: 2,
                                   )
                                 ]
                             ),child: Center(child: Text("Player X" ,style:customFont))),
                         Text(xScore.toString(),style: TextStyle(fontFamily: customFont.fontFamily,fontSize: 25,))
                       ],
                     )
                   ],
                 ),
               )),
           Expanded(flex:3,
               child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                   itemCount: 9,
                   itemBuilder: (BuildContext context,int index){
                      return GestureDetector(
                        onTap: (){
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: matchedIndexes.contains(index)?Colors.white:Colors.black26
                            ),
                            color: matchedIndexes.contains(index)?Colors.black:Colors.white
                          ),
                          child: Center(child: Text(
                            displayXO[index],
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                color: matchedIndexes.contains(index)?Colors.white:Colors.black,
                                fontSize: 64,
                              )

                            )
                          )),
                        ),
                      );
                   })),
           Expanded(flex:2,
               child: Column(
                 children: [
                   Text(resultDeclaration,style: customFont,),
                   SizedBox(height: 20,),
                   _buildTimer()
                 ],
               )),
          ],
        ),
      ),
    );
  }

  void _tapped(int index){
    final isRunning =timer==null?false:timer!.isActive;
    if(isRunning){
    setState(() {
      if(Oturn && displayXO[index]==""){
        displayXO[index]="O";
        filledBoxes++;
      }
      else if(!Oturn && displayXO[index]==""){
        displayXO[index]="X";
        filledBoxes++;
      }
    });
    Oturn=!Oturn;
    checkWinner();
    }
  }
  void checkWinner() {
    //first row
    if( displayXO[0] == displayXO[1] && displayXO[1]==displayXO[2]&&displayXO[0]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[0]} Wins';
      });
      _updateScore(displayXO[0]);_stopTimer();matchedIndexes.addAll([0,1,2]);
    }
    //secomd row
    else if( displayXO[3] == displayXO[4] && displayXO[4]==displayXO[5]&&displayXO[3]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[3]} Wins';
      });
      _updateScore(displayXO[3]);_stopTimer();matchedIndexes.addAll([3,4,5]);
    }
    //third row
    else if( displayXO[6] == displayXO[7] && displayXO[7]==displayXO[8]&&displayXO[6]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[6]} Wins';
      });
      _updateScore(displayXO[6]);_stopTimer();matchedIndexes.addAll([6,7,8]);
    }
    //first column
    else if( displayXO[0] == displayXO[3] && displayXO[3]==displayXO[6]&&displayXO[0]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[0]} Wins';
      });
      _updateScore(displayXO[0]);_stopTimer();matchedIndexes.addAll([0,3,6]);
    }
    //third column
    else if( displayXO[2] == displayXO[5] && displayXO[5]==displayXO[8]&&displayXO[2]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[2]} Wins';
      });
      _updateScore(displayXO[2]);_stopTimer();matchedIndexes.addAll([2,5,8]);
    }
    //secomd column
    else if( displayXO[1] == displayXO[4] && displayXO[4]==displayXO[7]&&displayXO[1]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[1]} Wins';
      });
      _updateScore(displayXO[1]);_stopTimer();matchedIndexes.addAll([1,4,7]);
    }
    //first diagonal
    else if( displayXO[0] == displayXO[4] && displayXO[4]==displayXO[8]&&displayXO[0]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[0]} Wins';matchedIndexes.addAll([0,4,8]);
      });
      _updateScore(displayXO[0]);_stopTimer();
    }
    //second diagonal
    else if( displayXO[2] == displayXO[4] && displayXO[4]==displayXO[6]&&displayXO[2]!=""){
      setState(() {
        resultDeclaration='Player ${displayXO[2]} Wins';matchedIndexes.addAll([2,4,6]);
      });
      _updateScore(displayXO[2]);_stopTimer();
    }
    //draw condition
    else if(!winnerFound && filledBoxes==9){
      setState(() {
        resultDeclaration="NOBODY WINS";_stopTimer();
      });
    }
  }

  void _updateScore(String winner){
    if(winner=="O"){
        oScore++;
    }
    else if(winner=='X'){
      xScore++;
    }
    winnerFound=true;
  }
   void _clearBoard() {
     setState(() {
       for (int i = 0; i < 9; i++) {
         displayXO[i] = "";
       }
       resultDeclaration = "";
     });
     filledBoxes=0;
     winnerFound=false;
   }
   Widget _buildTimer(){
    final isRunning =timer==null?false:timer!.isActive;

    return isRunning?
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1-seconds/maxSeconds,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 8,
                backgroundColor: Colors.white,
              ),
              Center(
                child: Text('$seconds',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 30),),
              )
            ],
          ),
        ): ElevatedButton(
        style:ElevatedButton.styleFrom(
          backgroundColor:Colors.black,
          padding: EdgeInsets.all(20),
        ),
        onPressed: (){
          _startTimer();
          _clearBoard();
          attempts++;
          matchedIndexes.clear();
        },
        child: Text(
            attempts==0 ?"Start":"Play Again",
            style:customFont)
    );

   }
}



